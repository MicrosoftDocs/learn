operation MarkingNumber (
    idxMarked : Int,
    inputQubits : Qubit [],
    target : Qubit
) : Unit is Adj+Ctl {
    (ControlledOnInt(idxMarked, X))(inputQubits, target);
}