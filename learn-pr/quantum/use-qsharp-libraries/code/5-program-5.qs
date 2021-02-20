    function IsIsbnValid(digits : Int[]) : Bool {
        // ensure array is 10 digits
        EqualityFactI(Length(digits), 10, "Expected a 10-digit number.");

        mutable acc = 0;
        for (idx, digit) in Enumerated(digits) {
            set acc += (10 - idx) * digit;
        }
        return acc % 11 == 0;
    }