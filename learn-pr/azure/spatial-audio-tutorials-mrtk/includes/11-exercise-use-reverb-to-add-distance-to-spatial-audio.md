In the previous exercise, you added spatialization for the sounds to give them a sense of direction. In this exercise you'll add a reverb effect to give sounds a sense of distance.

## Add a mixer group and a reverb effect

1. Previously, we added a mixer. The mixer includes one **Group** by default called **Master**. Because we'll only want to apply a reverb effect to some sounds, let's add a second Group for those sounds. To add a Group, right click on the Master group in the **Audio Mixer** choose **Add child group** and give suitable name for example _Room Effect_:

    :::image type="content" source="../media/add-child-group.png" alt-text="Screenshot of Add child group." lightbox="../media/add-child-group.png":::

2. Each **Group** has its own set of effects. Add a reverb effect to the new group by clicking **Add...** on the new group, and choosing **SFX Reverb**:

    :::image type="content" source="../media/add-sfx-reverb.png" alt-text="Screenshot of Add SFX Reverb." lightbox="../media/add-sfx-reverb.png":::

    In audio terminology, the original, unreverberated audio is called the _dry path_, and the audio after filtering with the reverb filter is called the _wet path_. Both paths are sent to the audio output, and their relative strengths in this mixture is called the _wet/dry mix_. The wet/dry mix strongly affects the sense of distance.

3. The **SFX Reverb** includes controls to adjust the wet/dry mix within the effect. Because the **Microsoft Spatializer** plugin handles the dry path, we'll be using the **SFX Reverb** only for the wet path. On the Inspector pane of your **SFX Reverb**:

    1) Set the **Dry Level** property to the lowest setting (-10000 mB)
    2) Set the **Room property** to the highest setting (0 mB)

    :::image type="content" source="../media/sfx-reverb-properties.png" alt-text="Screenshot of SFX Reverb properties." lightbox="../media/sfx-reverb-properties.png":::

    The other settings control the feel of the simulated room. In particular, **Decay Time** is related to perceived room size.

## Enable reverb on the video playback

1. Uncomment the 4 commented lines in the **SpatializeOnOff** script. The script will now look like this:

    ```c#
    using System.Collections;
    using System.Collections.Generic;
    using UnityEngine;
    using UnityEngine.Audio;

    [RequireComponent(typeof(AudioSource))]
    public class SpatializeOnOff : MonoBehaviour
    {
        public GameObject ButtonTextObject;
        public AudioMixerGroup RoomEffectGroup;
        public AudioMixerGroup MasterGroup;

        private AudioSource m_SourceObject;
        private bool m_IsSpatialized;
        private TMPro.TextMeshPro m_TextMeshPro;

        public void Start()
        {
            m_SourceObject = gameObject.GetComponent<AudioSource>();
            m_TextMeshPro = ButtonTextObject.GetComponent<TMPro.TextMeshPro>();
            SetSpatialized();
        }

        public void SwapSpatialization()
        {
            if (m_IsSpatialized)
            {
                SetStereo();
            }
            else
            {
                SetSpatialized();
            }
        }

        private void SetSpatialized()
        {
            m_IsSpatialized = true;
            m_SourceObject.spatialBlend = 1;
            m_TextMeshPro.SetText("Set Stereo");
            m_SourceObject.outputAudioMixerGroup = RoomEffectGroup;
        }

        private void SetStereo()
        {
            m_IsSpatialized = false;
            m_SourceObject.spatialBlend = 0;
            m_TextMeshPro.SetText("Set Spatialized");
            m_SourceObject.outputAudioMixerGroup = MasterGroup;
        }
    }

2. Once these lines are uncommented  it adds two properties to the Inspector of the **SpatializeOnOff script**. Assign these on the Inspector window of **SpatializeOnOff** component of the **Quad**:

    1) Set the **Room Effect Group** property to your new Room Effect mixer group
    2) Set the **Master Group** property to the Master mixer group

    :::image type="content" source="../media/spatialize-on-off.png" alt-text="Spatialize On Off Extended." lightbox="../media/spatialize-on-off.png":::
