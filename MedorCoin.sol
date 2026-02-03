You defined NAME and SYMBOL twice in two different ways.

You have these constants:
	•	bytes32 public constant NAME
	•	bytes32 public constant SYMBOL

And you also have these functions:
	•	function name()
	•	function symbol()

This is not valid ERC20 design. Wallets, explorers, and Remix expect one source of truth, not both.
