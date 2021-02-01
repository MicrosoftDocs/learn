operation SetQubitState(desired : Result, q : Qubit) : Result {
    if (desired != M(q)) {
        X(q);
        return M(q);
    }
}