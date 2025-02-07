# record_and_play_audio_app

A new Flutter project.

## Getting Started

This project lets you record and voice and then play it.

## Widgets used in HomePage:
  - Scaffold
      - AppBar to put the title of the page on it
      - body
          - Column to put widgets vertically
              - GlobalButton with mic shape
                  - when this button is pressed, it checks if it's already recording, then stop it
                  - if it's not, it requests user permission to use microphone
                  - then, it checks if it's not playing an audio and mic permission is granted, then it will start recording
              - Message to show "Recording.." if it's recording
              - - GlobalButton with play shape
                  - when this button is pressed, it checks if it's already playing an audio, then stop it
                  - if it's not, it checks if it's not recording an audio, then it will start playing the recorded audio
              - Message to show "Playing.." if it's playing the audio
