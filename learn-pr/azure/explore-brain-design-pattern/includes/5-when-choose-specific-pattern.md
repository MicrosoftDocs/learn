Here are some suggestions about when to use each pattern:

- If the observation space is very large with many sensor inputs, try the Perception Pattern. Perception modules can help reduce the number of variables that action concepts need to make good decisions.

- If the observation space is very large with many sensor inputs when considering all scenarios of interest, try the Strategy Pattern. The Strategy pattern helps organize and classify scenarios. You may not need every variable to control well in every scenario.

- If the environment is difficult to assess, try the Perception Pattern. Perceptive concepts can help make sense of complex environments. For example, a weather predictor can greatly assist in making decisions about weather dependent systems.

- If the action space is very large, try a Functional Decomposition. You may be able to separate actions into groups. For example, not every player on the football field is doing the same thing. Some are playing offense, and some are playing defense. Therefore, you could compartmentalize strategies applicable only to a specific subset of players based on each playing scenario.