In this unit, you’ll learn accessibility considerations and best practices related to accessible hardware connections and the operation of mechanical parts. By applying this learning, you can create more accessible experiences for players.

## Provide standard hardware connections

Many players who use assistive technologies (AT) like braille readers or adaptive input devices must connect their AT directly to their gaming device. Players unable to directly connect their AT to their gaming device can be blocked from gameplay altogether.

Many AT devices only support standard hardware connection types. Standard hardware connections are non-proprietary forms of connecting one device to another. USB is considered the standard connection for physical connection types. For wireless connections, Bluetooth is considered the standard.

In addition to any other connection types that your device will feature, standard connections like USB ports and Bluetooth pairing compatibility should also be provided. It will ensure that players can connect and use their assistive technologies to engage in gameplay.

## Consider device weight and shape

Think about how a customer may grab or pick up their device. Devices that are heavy or difficult to grasp, such as a console, easily be dropped and damaged. In general, considering ways to make devices lighter and easier to pick up is an accessibility support that benefits all customers.

## Improve accessible operation of mechanical parts

An important aspect to consider when creating accessible hardware experiences for players is the strength, dexterity, and fine motor skills required to interact with and operate the device. Consider the actions a player may need to perform such as pressing buttons or opening battery doors. If a player cannot physically press the power button, make volume adjustments, or pair the device, they may stop using the device altogether.

The following aspects of hardware components can be optimized to create hardware experiences that are accessible for more players with limited strength, dexterity, coordination, or fine motor skills in their arms, hands, or fingers.

### Button size

The physical surface area of a button can impact whether a user with disabilities can activate it. Buttons on devices have been designed under the assumption that players can isolate and use a single fingertip to press the button. However, some players may need to use larger body parts, like a knuckle, residual limb following amputation, or palm, to activate controls. Intentional decisions made to maximize button size on devices can create more accessible experiences for players who must use body parts other than fingertips to access buttons.

The image below shows a person’s hand as they press a button on a USB speaker device. The larger buttons on the device are about the size of a US penny. The increased surface area of the buttons on this device can make it easier for players to control the speaker device.

:::image type="content" source="../media/usbc-speaker.png" alt-text="A hand pressing a USB speaking device with large buttons on it for volume and muting.":::

Similarly, the size of the A and B buttons on the Xbox Adaptive Controller were, by design, made larger. The larger size helps players use the controller even though they may not be able to isolate a single finger to press the buttons.

:::image type="content" source="../media/xac.jpg" alt-text="A player in a wheelchair using an Xbox Adaptive Controller on a lap board.":::

### Button height

For this module, the term button height refers to the difference in height between the top of the button and its surrounding material. Ask yourself, is the button raised, or is it completely flush with the rest of the device?

Buttons that are flush with the surrounding device material can create accessibility barriers. For users without vision, buttons may be located through touch. Buttons that are flush with their surrounding may not be discernable by touch. If the user cannot find the button, they cannot use it to perform the desired action. Buttons that are raised from the surface of the device can help with the discoverability of the button location.

Design for accidental activation should be balanced with removing accessibility barriers when determining button height. Buttons should be discoverable and pressable for players with disabilities.

### Activation force

Another important aspect of hardware accessibility is the amount of force a player must exert to activate a button or generate input. To prevent accidental activation, developers may intentionally configure an item to require more force to perform an action. For example, items often carried in backpacks, like a headset, may be intentionally designed to require a higher activation force for buttons so they are not activated accidentally in transit.

Considerations around the force needed to operate controls should be factored into hardware design and development. The 2010 Americans with Disabilities Act Standards for Accessible Design Best suggest a maximum of 5 lb., or 22.N Newtons, for activation force of operable parts. For smaller parts like buttons and keys, lower activation forces should be considered. For example:

- The Xbox One console’s touch-based power button can be activated with 0g of force.  
- Most keys on a standard keyboard can be activated with 45 grams to 70 grams of force.
- “Ultra” light assistive technology switches can be activated with as low as 20 g of force.

Button size and activation force are equally important when creating accessible experiences for players.

### Methods of activation

The movements a player must perform to use a device also influence device accessibility. For example, the use of a volume "knob" that players must grasp and twist their hand or wrist to either side to raise or lower volume settings can pose difficulty for some players. Another is the physical demands associated with holding down a button for a prolonged period to initiate Bluetooth pairing mode.

When designing and creating new devices, consider avoiding activation methods that require players to perform twisting motions or prolonged time to complete an action. In cases where this is not possible, consider providing alternative methods to perform these actions that are less physically demanding, such as software-based device management applications that can be run on the player's phone, console, or PC.

For example, the image below shows the ear cup dials on an Xbox gaming headset. Players must twist the dials to adjust the volume and chat mixer values. However, for players who are unable to perform twisting motions, an opportunity to adjust volume and chat mixer volumes is provided through the Xbox Accessories App. This allows players to use the input device of their choice to raise and lower headset values without hands-on twisting motions.

:::image type="content" source="../media/xbox-wireless-headset.png" alt-text="A pair of Xbox-branded headphones with a boom microphone.":::

:::image type="content" source="../media/headset-control-ui.png" alt-text="The Xbox audio & music settings panel. The headset volume selector is highlighted.":::

### Component location

Another important consideration is the location of the controls on a device. Consider a headset with the volume controls located on the left ear cup, and the noise cancellation controls located on the right ear cup. A player with limited movement in one arm or an amputation may only be able to reach the side with volume controls, and not the noise cancellation controls on the other side of the device.

In this situation, the location of the controls cannot be moved. An alternative approach could include a software option that allows players to swap the controls for volume and noise cancellation between the right and left ear cups. This would support this player in "accessing" both control types despite only being able to physically reach one side of their device while it's on their head.

Other general best practice considerations to account for hardware component location include:

- Providing players with an alternative, accessible way to control the device such as adding a volume control to the auxiliary cord that connects the headphones to the gaming device
- Providing controls on a separate device that can be placed in a convenient location, such as a dial that can be placed on a table.
- Providing accessibility settings that allow players to customize the functions of each physical control through software.

For example, the image below shows the controller remapping screen for the Xbox Elite controller. The player who created this profile has difficulty accessing the “Left stick click” control. Through software, they reassigned this control to an option that they can more easily reach and press, in this case, the right trigger.

:::image type="content" source="../media/controller-map-high-contrast.png" alt-text="A screenshot of the Xbox Elite Controller configuration screen. The Map to field is highlighted and Right Trigger is selected.":::
