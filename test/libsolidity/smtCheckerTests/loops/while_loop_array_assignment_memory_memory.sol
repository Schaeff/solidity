pragma experimental SMTChecker;

contract LoopFor2 {
	function testUnboundedForLoop(uint n, uint[] memory b, uint[] memory c) public pure {
		require(n < b.length);
		require(n < c.length);
		require(n > 0 && n < 100);
		b[0] = 900;
		uint[] memory a = b;
		uint i;
		while (i < n) {
			// Accesses are safe but oob is reported due to potential aliasing after c's assignment.
			b[i] = i + 1;
			c[i] = b[i];
			++i;
		}
		// Removed because current Spacer seg faults in cex generation.
		//assert(b[0] == c[0]);
		// Removed because current Spacer seg faults in cex generation.
		//assert(a[0] == 900);
		// Removed because current Spacer seg faults in cex generation.
		//assert(b[0] == 900);
	}
}
// ====
// SMTIgnoreCex: yes
// SMTSolvers: z3
// ----
// Warning 2072: (235-250): Unused local variable.
// Warning 6368: (379-383): CHC: Out of bounds access happens here.
// Warning 1218: (396-400): CHC: Error trying to invoke SMT solver.
// Warning 6368: (396-400): CHC: Out of bounds access might happen here.
// Warning 6368: (403-407): CHC: Out of bounds access happens here.
