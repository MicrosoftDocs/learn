    function GetIsbnCheckConstants(digits : Int[]) : (Int, Int) {
        EqualityFactI(Length(digits), 10, "Expected a 10-digit number.");
        // |(b + a x) mod 11 ⟩
        mutable a = 0;
        mutable b = 0;
        for ((idx, digit) in Enumerated(digits)) {
            if (digit < 0) {
                set a = 10 - idx;
            }
            else {
                set b += (10 - idx) * digit;
            } 
        }
        return (a, b % 11);
    }