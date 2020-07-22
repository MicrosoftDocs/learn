
## Estimate energy by evolving state by Hamiltonian
- States evolve according to their Hamiltonian
- overview of state evolution under action of hamiltonian: $\ket{\psi(t)} = e^{i H t} \ket{\psi(0)}$
- overview of phase est algorithm to estimate the energy (i.e. eigenvalue of matrix $H$) by applying the operations which correspond to $e^{i H t}$ for a given amount of time $t$

## Trotterization of propagator
- New problem: even though we have $H$ in the JW representation which corresponds to qubits, the operations which correspond to $e^{i H t}$ are not straightforward.
- Trotterization is one method of breaking up of $e^{i H t}$ into smaller pieces, each applied for a fraction of $t$.
- (illustrate with eqs)

## Use the quantum chemistry library

For input to the energy estimation operation, we need to provide the general algorithm (phase estimation), as well as:
- the oracle to use which corresponds to each Trotter step
- the number of physical qubits needed
- the input trial ground state (already provided in `JWEncodingData`)

```qsharp
    operation GetEnergyByTrotterization (qSharpData : JordanWignerEncodingData, nBitsPrecision : Int, trotterStepSize : Double, trotterOrder : Int) : (Double, Double) {

        let (nSpinOrbitals, fermionTermData, statePrepData, energyOffset) = qSharpData!;

        let (nQubits, (rescaleFactor, oracle)) = TrotterStepOracle(qSharpData, trotterStepSize, trotterOrder); // M.Q.C.JW
        
        let statePrep = PrepareTrialState(statePrepData, _); // M.Q.C.JW
        
        let phaseEstAlgorithm = RobustPhaseEstimation(nBitsPrecision, _, _); // M.Q.Characterization
        
        let estPhase = EstimateEnergy(nQubits, statePrep, oracle, phaseEstAlgorithm); // M.Q.Simulation
        
        // We obtain the energy estimate by rescaling the phase estimate with the trotterStepSize. 
        // We also add the constant energy offset to the estimated energy.
        let estEnergy = estPhase * rescaleFactor + energyOffset;
        
        // We return both the estimated phase, and the estimated energy.
        return (estPhase, estEnergy);
    }
```
