module lock_fsm (
    input  wire hw_clk,
    input  wire btn_toggle,
    input  wire btn_enter,
    input  wire btn_next,
    input  wire btn_reset,

    output reg led_red,
    output reg led_green,
    output reg led_blue,
    output reg buzzer,
    output wire relay_ctrl
);

    // ==================================================
    // PASSWORD (user order: bit0 bit1 bit2)
    // ==================================================
    parameter [2:0] PASSWORD = 3'b101;

    // ==================================================
    // FSM STATES
    // ==================================================
    parameter LOCKED   = 3'd0;
    parameter ENTER0   = 3'd1;
    parameter ENTER1   = 3'd2;
    parameter ENTER2   = 3'd3;
    parameter LATCH    = 3'd4;
    parameter CHECK    = 3'd5;
    parameter UNLOCKED = 3'd6;
    parameter ERROR    = 3'd7;

    reg [2:0] state = LOCKED;
    reg [2:0] next_state;

    reg [2:0] input_code;
    reg [2:0] code_latched;

    // ==================================================
    // SLOW CLOCK (BUTTON-FRIENDLY ~20–30 Hz)
    // ==================================================
    reg [21:0] slow_cnt;
    always @(posedge hw_clk)
        slow_cnt <= slow_cnt + 1;

    wire slow_clk = slow_cnt[21];

    // ==================================================
    // TIMERS & EDGE DETECTION
    // ==================================================
    reg [7:0] unlock_timer; // Timer to auto-relock
    reg btn_toggle_d, btn_next_d, btn_enter_d;
    wire toggle_pressed = btn_toggle_d & ~btn_toggle;
    wire next_pressed   = btn_next_d   & ~btn_next;
    wire enter_pressed  = btn_enter_d  & ~btn_enter;

    reg [5:0] buzz_count;

    // ==================================================
    // SEQUENTIAL LOGIC (RESET PRIORITY & TIMERS)
    // ==================================================
    always @(posedge slow_clk) begin
        if (btn_reset == 1'b0) begin // Priority Reset (Active LOW) 
            state <= LOCKED;
            input_code <= 3'b000;
            code_latched <= 3'b000;
            btn_toggle_d <= 1'b1;
            btn_next_d   <= 1'b1;
            btn_enter_d  <= 1'b1;
            buzz_count <= 6'd0;
            unlock_timer <= 8'd0;
        end else begin
            btn_toggle_d <= btn_toggle;
            btn_next_d   <= btn_next;
            btn_enter_d  <= btn_enter;
            state <= next_state;

            // Handle Input Bits
            if (toggle_pressed) begin
                if (state == ENTER0)      input_code[0] <= ~input_code[0];
                else if (state == ENTER1) input_code[1] <= ~input_code[1];
                else if (state == ENTER2) input_code[2] <= ~input_code[2];
            end

            if (state == LOCKED && next_state == ENTER0)
                input_code <= 3'b000;
            
            if (state == ENTER2 && next_state == LATCH)
                code_latched <= input_code;

            // Unlock Timer Management
            if (state == UNLOCKED) begin
                if (unlock_timer < 8'd100) // ~3 seconds at slow_clk frequency
                    unlock_timer <= unlock_timer + 1;
            end else begin
                unlock_timer <= 8'd0;
            end

            // Buzzer Timing
            if (state == CHECK && next_state == UNLOCKED)
                buzz_count <= 6'd10;
            else if (state == CHECK && next_state == ERROR)
                buzz_count <= 6'd25;

            if (buzz_count > 0) buzz_count <= buzz_count - 1'b1;
        end
    end

    // ==================================================
    // NEXT STATE LOGIC (WITH AUTO-RELOCK)
    // ==================================================
    always @(*) begin
        next_state = state;
        case (state)
            LOCKED:   if (enter_pressed) next_state = ENTER0;
            ENTER0:   if (next_pressed)  next_state = ENTER1;
            ENTER1:   if (next_pressed)  next_state = ENTER2;
            ENTER2:   if (enter_pressed) next_state = LATCH;
            LATCH:    next_state = CHECK;
            CHECK: begin
                if ({code_latched[0], code_latched[1], code_latched[2]} == PASSWORD)
                    next_state = UNLOCKED;
                else
                    next_state = ERROR;
            end
            UNLOCKED: 
                // Relock if timer expires OR Enter is pressed
                if (unlock_timer >= 8'd100 || enter_pressed)
                    next_state = LOCKED;
            ERROR:    
                if (enter_pressed) next_state = LOCKED;
            default:  next_state = LOCKED;
        endcase
    end

    // ==================================================
    // OUTPUT LOGIC
    // ==================================================
    always @(*) begin
        led_red   = 1'b1;
        led_green = 1'b1;
        led_blue  = 1'b1;

        if (state == UNLOCKED)
            led_green = 1'b0; // Green LED when relay is active 
        else if (state == LOCKED)
            led_red = 1'b0;   // Red LED when locked 
        else if (state == ERROR || state == ENTER0 || state == ENTER1 || state == ENTER2)
            led_blue = 1'b0;  // Blue LED during input/error 
    end

    assign buzzer = (buzz_count > 0);
    // Relay is Active LOW (clicks when state is UNLOCKED) 
    assign relay_ctrl = (state == UNLOCKED) ? 1'b0 : 1'b1;

endmodule
