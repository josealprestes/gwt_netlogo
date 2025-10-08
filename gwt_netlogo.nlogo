;; GLOBAL WORKSPACE THEORY (GWT) SIMULATION MODEL
;; Author: José Augusto de Lima Prestes
;; Date: 2025
;; BREED AND GLOBAL/AGENT VARIABLE DECLARATIONS
breed [workspaces workspace]
breed [processors processor]
breed [stimuli stimulus]
globals [
winner ;; Stores the winning processor for each tick
]
workspaces-own [
current-focus-message ;; The "message" that is in focus
current-focus-urgency ;; The urgency of the message in focus
focus-source          ;; Who sent the message in focus
]
processors-own [
processor-type ;; "visual", "auditory", "memory"
urgency        ;; The activation level of the processor
message        ;; The information the processor wants to broadcast
]
stimuli-own [
stimulus-type ;; "visual" or "auditory"
lifespan      ;; How long the stimulus lasts
]
;; INITIAL SETUP PROCEDURE
to setup
  clear-all
  setup-workspace
  setup-processors
  reset-ticks
end

to setup-workspace
  create-workspaces 1 [
    setxy 0 0
    set shape "circle"
    set color yellow
    set size 4
    set label "Global Workspace"
    set current-focus-message "..."
    set current-focus-urgency 0
    set focus-source nobody
  ]
end

to setup-processors
  let radius world-width / 3
  ;; Create visual processors
  repeat num-processors-per-type [
    create-processors 1 [
      set processor-type "visual"
      set color red
      set shape "circle"
      set size 2
      ;; Position in an arc on the left
      let angle (90 + (who * 15))
      setxy (radius * cos angle) (radius * sin angle)
      set label "V"
      set urgency 0
    ]
  ]
  ;; Create auditory processors
  repeat num-processors-per-type [
    create-processors 1 [
      set processor-type "auditivo"
      set color blue
      set shape "circle"
      set size 2
      ;; Position in an arc on the right
      let angle (-90 + (who * 15))
      setxy (radius * cos angle) (radius * sin angle)
      set label "A"
      set urgency 0
    ]
  ]
end

;; MAIN SIMULATION LOOP
to go
  generate-stimuli
  manage-stimuli
  activate-processors
  compete-for-focus
  broadcast-and-react
  decay-urgency
  update-visuals
  tick
end

;; LOOP PROCEDURES
to generate-stimuli
  ;; Chance to create a new stimulus on each tick
  if random-float 1.0 < stimulus-frequency [
    create-stimuli 1 [
      set shape "square"
      set size 1.5
      set lifespan 50 ;; Lasts for 50 ticks
      ;; Randomly determines if the stimulus is visual or auditory
      ifelse random 2 = 0 [
        set stimulus-type "visual"
        set color red - 1
        setxy random-xcor / 2 - world-width / 4  random-ycor
      ] [
        set stimulus-type "auditivo"
        set color blue - 1
        setxy random-xcor / 2 + world-width / 4  random-ycor
      ]
    ]
  ]
end

to manage-stimuli
  ask stimuli [
    set lifespan lifespan - 1
    if lifespan <= 0 [ die ]
  ]
end

to activate-processors
  ask processors [
    ;; Search for nearby stimuli of its own type
    let nearby-stimuli stimuli in-radius 5 with [stimulus-type = [processor-type] of myself]
    if any? nearby-stimuli [
      ;; If found, increase urgency and define a message
      set urgency urgency + activation-boost
      set message (word processor-type " " precision (random-float 1) 2)
    ]
  ]
end

to compete-for-focus
  let current-workspace one-of workspaces
  set winner max-one-of processors [urgency]
  let success? (winner != nobody and [urgency] of winner > urgency-threshold)

  ;; If the success condition is true...
  if success? [
    ask current-workspace [
      set current-focus-message [message] of winner
      set current-focus-urgency [urgency] of winner
      set focus-source winner
    ]
  ]

  ;; If the success condition is false...
  if not success? [
    ask current-workspace [
      set current-focus-message "..."
      set current-focus-urgency (current-focus-urgency * 0.9)
      set focus-source nobody
    ]
  ]
end

to broadcast-and-react
  ;; This is a simple reaction procedure. In a more complex model,
  ;; the other processors could use the 'current-focus-message' information
  ;; to perform tasks or change their own states.

  ;; All processors return to their normal color
  ask processors [
    ifelse processor-type = "visual" [ set color red ][ set color blue ]
  ]
  ;; The winner of the competition turns white to indicate it is "in focus"
  if [focus-source] of one-of workspaces != nobody [
    ask [focus-source] of one-of workspaces [
      set color white
    ]
  ]
end

to decay-urgency
  ;; The urgency of all processors decays over time
  ask processors [
    set urgency urgency * (1 - decay-rate)
  ]
end

to update-visuals
  ;; Clear old links
  ask links [ die ]
  let current-workspace one-of workspaces
  ;; Create a link from the winner to the workspace for visualization
  if [focus-source] of current-workspace != nobody [
    ask [focus-source] of current-workspace [
      create-link-with current-workspace [
        set color yellow
        set thickness 0.2
      ]
    ]
  ]
  ;; Update the Workspace label
  ask current-workspace [
    set label (word "Focus: " current-focus-message)
  ]
end
@#$#@#$#@
GRAPHICS-WINDOW
145
45
871
772
-1
-1
21.76
1
10
1
1
1
0
1
1
1
-16
16
-16
16
0
0
1
ticks
30.0

BUTTON
1472
109
1536
142
Setup
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
1550
109
1613
142
Go
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
1454
168
1644
201
num-processors-per-type
num-processors-per-type
1
10
5.0
1
1
NIL
HORIZONTAL

SLIDER
1462
233
1634
266
stimulus-frequency
stimulus-frequency
0.01
0.5
0.15
0.01
1
NIL
HORIZONTAL

SLIDER
1463
301
1635
334
activation-boost
activation-boost
1
20
20.0
1
1
NIL
HORIZONTAL

SLIDER
1464
370
1636
403
urgency-threshold
urgency-threshold
1
30
15.0
1
1
NIL
HORIZONTAL

SLIDER
1464
434
1636
467
decay-rate
decay-rate
0.01
0.5
0.01
0.01
1
NIL
HORIZONTAL

PLOT
978
47
1341
328
Níveis de Urgência
time
urgency
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"pen-1" 1.0 0 -2674135 true "" "plot [urgency] of one-of processors with [processor-type = \"visual\"]"
"pen-2" 1.0 0 -13345367 true "" "plot [urgency] of one-of processors with [processor-type = \"auditivo\"]"
"pen-3" 1.0 0 -1184463 true "" "plot [current-focus-urgency] of one-of workspaces"

MONITOR
1069
361
1261
406
Foco Atual
[current-focus-message] of one-of workspaces
17
1
11

@#$#@#$#@
## WHAT IS IT?

This model is a simulation of an **Artificial Consciousness** concept based on the **Global Workspace Theory (GWT)**, as proposed by neuroscientist Bernard Baars.

The theory suggests that consciousness functions like a "theater of the mind." Many "actors" (cognitive and sensory processes) operate unconsciously behind the scenes. Consciousness is the "spotlight" that illuminates a single actor at a time, placing them on the "stage." Once on stage, that actor's information is broadcast globally to the entire audience (the other unconscious processes).

This simulation aims to demonstrate and visualize, in a simplified way, how this mechanism of competition and information broadcasting can give rise to behaviors analogous to human consciousness, such as:

* Selective attention (focusing on one thing at a time).
* Redirection of attention (being interrupted by a more important event).
* A "stream of consciousness" (the succession of different attentional focuses over time).

## HOW IT WORKS

The model is composed of three types of agents:

* **Processors:** Red (visual) and blue (auditory) circles. They represent specialized modules of the brain. Each processor has a key variable: `urgency`.
* **Stimuli:** Red and blue squares that appear randomly. They represent information from the environment.
* **Global Workspace:** The large yellow circle in the center. It represents the "focus of consciousness."

The operational cycle follows these rules:

1.  **Activation:** When a Stimulus appears near a Processor of the same type, that processor's `urgency` instantly increases (controlled by the **activation-boost** slider).
2.  **Decay:** At each time step, the `urgency` of all processors decreases slightly, simulating forgetting or loss of relevance (controlled by **decay-rate**).
3.  **Competition:** At each time step, the model checks which processor has the highest `urgency`.
4.  **Selection:** If the processor with the highest `urgency` is above an importance threshold (**urgency-threshold**), it is declared the "winner."
5.  **Consciousness:** The winner's information (its message) is copied to the Global Workspace. Visually, the winning processor turns white and a link connects it to the center.

## HOW TO USE IT

1.  Press the **setup** button to create the world, positioning the processors and the global workspace.
2.  Press the **go** button to start and run the simulation continuously.
3.  Use the **Sliders** to control the simulation's parameters:
    * **num-processors-per-type:** Sets how many processors of each type (visual/auditory) exist.
    * **stimulus-frequency:** Controls how often new stimuli appear in the environment.
    * **activation-boost:** Defines the strength of a processor's initial reaction to a stimulus.
    * **urgency-threshold:** The "importance filter." A processor can only become conscious if its urgency exceeds this value.
    * **decay-rate:** Controls the speed at which processors "forget" a stimulus.

## THINGS TO NOTICE

* **The White Agent:** Notice that only **one** processor is white at a time. This represents the serial nature of consciousness—we focus on one thing at a time.
* **The Stream of Consciousness:** Watch how the white agent "jumps" from one processor to another, sometimes staying on one for a while, other times changing rapidly. This is the stream of consciousness in action.
* **The Plot:** Follow the "Níveis de Urgência" (Urgency Levels) plot. The yellow line (Focus) should always "jump" to track the line of the winning processor (either red or blue).
* **The Competition:** Set a high stimulus frequency and watch the "battle" for attention happen in real-time on the plot.

## THINGS TO TRY

* **Simulate a 'Distracted/Anxious Brain':** Set **stimulus-frequency** and **decay-rate** to high values, and **urgency-threshold** to a low value. Observe how the focus jumps frantically from one stimulus to another, unable to settle on anything.
* **Simulate a 'Calm/Focused Brain':** Set **stimulus-frequency** and **decay-rate** to low values, and **urgency-threshold** to a high value. See how the focus becomes much more stable, captured only by rare events and holding attention for longer.
* **"Turn Off" Consciousness:** What happens if you set **activation-boost** to a value **lower** than **urgency-threshold**? (Answer: The processors will react, but no event will be "important" enough to become conscious. The focus will never activate).

## EXTENDING THE MODEL

* **Add Internal Thoughts:** Create a new type of processor (e.g., "memory," colored green) that doesn't react to external stimuli but spontaneously generates its own peaks of urgency, simulating a thought or memory that "pops into your head."
* **Create Actions:** Have the Global Workspace agent perform an action based on the current focus. For example, if the focus is "visual," the central agent could move towards the visual stimulus.
* **Inhibition Mechanisms:** Modify the code so that when one processor wins the focus, the urgency of other processors is temporarily suppressed, simulating the inhibition of distractions.

## NETLOGO FEATURES

This model uses several important NetLogo features:

* **`breed`:** Used to create different categories of agents (workspaces, processors, stimuli) with their own unique variables.
* **`max-one-of [agentset] [variable]`:** This command is the heart of the competition mechanism. It efficiently finds the agent in an agentset that has the maximum value for a specific variable (`urgency`, in our case).
* **Dynamic Visualization:** The model makes extensive use of visual commands (**set color**, **create-link-with**, **set label**) to make the abstract internal state of the simulation (the "focus") easy to see and interpret.

## CREDITS AND REFERENCES

* **Model Author:** José Augusto de Lima Prestes
* **Date:** September, 2025
* **Primary Theoretical Reference:** Baars, Bernard J. (1988). *A Cognitive Theory of Consciousness*. Cambridge, MA: Cambridge University Press.
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.4.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
