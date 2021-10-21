In this unit, you’ll learn accessibility considerations and best practices related to accessible hardware connections and the operation of mechanical parts. By applying this learning, you can create more accessible experiences for players.

## Provide standard hardware connections

Many players who use assistive technologies (AT) like braille readers or adaptive input devices must connect their AT directly to their gaming device. Players unable to directly connect their AT to their gaming device can be blocked from gameplay altogether.

Many AT devices only support standard hardware connection types. Standard hardware connections are non-proprietary forms of connecting one device to another. USB is considered the standard connection for physical connection types. For wireless connections, Bluetooth is considered the standard.

In addition to any other type of connection present on the device you're developing, standard connections like USB ports and Bluetooth pairing compatibility should also be provided as an option. It will ensure that players can connect and use their assistive technologies to engage in gameplay.

## Improve accessible operation of mechanical parts

An important aspect to consider when creating accessible hardware experiences for players is the strength, dexterity, and fine motor skills required to interact with and operate the device. Actions the player may need to perform include pressing buttons and opening battery doors. If a player cannot physically press the power button, make volume adjustments, or pair the device, they may stop using the device altogether.

Consider the following information when creating hardware experiences to ensure they are more accessible for players with limited strength, dexterity, coordination, or fine motor skills in their arms, hands, or fingers.

### Button size

The physical surface area of a button can impact whether a user with disabilities can activate it. Buttons on devices have been designed under the assumption that players can isolate and use a single fingertip to press the button. However, users with disabilities may need to use larger body parts, like a knuckle, residual limb, or palm, to activate controls. Intentional design decisions made to maximize button size on devices with limited surface area can create more accessible experiences for players who use body parts other than fingertips to access buttons.

The image below shows a person’s hand as they press a button on a USB speaker device. The larger buttons on the device are about the size of a US penny. The increased surface area of the buttons on this device can make it easier for players to control the speaker device.

:::image type="content" source="../media/usbc-speaker.png" alt-text="A hand pressing a USB speaking device with large buttons on it for volume and muting.":::

Similarly, the size of the A and B buttons on the Xbox Adaptive Controller were, by design, made larger. The larger size helps players use the controller even though they may not be able to isolate a single finger to press the buttons.

:::image type="content" source="../media/xac.jpg" alt-text="A player in a wheelchair using a Xbox Adaptive Controller on a lap board.":::

### Button height

For this module, the term button height refers to the difference in height between the top of the button and its surrounding material. Ask yourself, is the button raised, or is it completely flush with the rest of the device?

Buttons that are flush  with the surrounding device material can create accessibility barriers. For users without vision, buttons may be located through touch. Buttons that are flush with their surrounding may not be discernable by touch. If the user cannot find the button, they cannot use it to perform the desired action. Buttons that are raised from the surface of the device can help with the discoverability of the button location.

Design for accidental activation should be balanced with removing accessibility barriers when determining button height. Buttons should be discoverable and pressable for players with disabilities.

### Activation force

Another important aspect of hardware accessibility is the amount of force a player must exert to activate a button or generate input. To prevent accidental activation, developers may intentionally configure an item to require more force to perform an action. For example, items often carried in backpacks, like a headset, may be intentionally designed to require a higher activation force for buttons so they are not activated accidentally in transit.

Considerations around the force needed to operate controls should be factored into hardware design and development. The 2010 Americans with Disabilities Act Standards for Accessible Design Best suggest a maximum of 5 lb., or 22.N Newtons, for activation force of operable parts. For smaller parts like buttons and keys, lower activation forces should be considered. For example:

- The Xbox One console’s touch-based power button can be activated with 0g of force.  
- Most keys on a standard keyboard can be activated with 45 grams to 70 grams of force.
- “Ultra” light assistive technology switches can be activated with as low as 20 g of force.

Button size and activation force are equally important when creating accessible experiences for players.

### Methods of activation

The movement a player must perform to use a device should be considered when creating accessible experiences for players. For example, the method of activation for a volume control may require the user to grasp a knob and twist their hand or wrist to either side to raise or lower volume. The method of activation to pair a Bluetooth device often requires pressing a button for a prolonged time.

When designing and creating new devices, it's recommended to avoid activation methods that require players to perform twisting motions or prolonged time to complete an action. In cases where this is not possible, consider providing alternative solutions, designed with accessibility in mind, to complete the required action. For example, if your product is already in the market, consider creating an application that can be installed on a phone, gaming console, or PC as an accessible alternative for managing the device.

The image below shows the ear cup dials on an Xbox gaming headset. Players twist the dials to adjust the volume and chat mixer values. Players unable to perform the necessary twisting motions can instead use the Xbox Accessories app. This app provides a configuration settings menu for players to use to adjust the settings.

:::image type="content" source="../media/xbox-wireless-headset.png" alt-text="A pair of Xbox-branded headphones with a boom microphone.":::

:::image type="content" source="../media/headset-control-ui.png" alt-text="The Xbox audio & music settings panel. The headset volume selector is highlighted.":::

### Component location

The location of the controls on a device is also important to consider when designing and developing accessible hardware. Consider a headset with the volume control on one side of the device and the noise cancellation control on the other side of the device. Players who are not able to perform the action required to reach or use the controls while the headset is on their head, such as those with reduced mobility on one side of their body, will not be able to use the device efficiently.

If ideal component placement cannot be achieved, the following considerations can be used to enhance the accessibility of the experience:

- Provide players with an alternative, accessible way to control the device such as adding a volume control to the auxiliary cord that connects the headphones to the gaming device
- Provide controls on a separate device that can be placed in a convenient location, such as a dial that can be placed on a table.
- Provide accessibility settings that allow players to customize the functions of each physical control through software.

For example, the image below shows the controller remapping screen for the Xbox Elite controller. The player who created this profile has difficulty accessing the “Left stick click” control. Through software they re-assigned this control to an option that they can more easily access, in this case, the right trigger.

:::image type="content" source="../media/controller-map-high-contrast.png" alt-text="The Xbox Elite Controller configuration screen. The Map to field is highlighted and Right Trigger is selected.":::