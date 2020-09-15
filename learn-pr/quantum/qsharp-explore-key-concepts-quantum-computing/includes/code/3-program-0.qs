namespace ExploringSuperposition {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Diagnostics;

    @EntryPoint()
    operation SayHello() : Unit {
        Message("Hello quantum world!");
    }
}