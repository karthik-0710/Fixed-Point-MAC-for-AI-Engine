# Fixed-Point-MAC-for-AI-Engine
For this project, we would perform MAC on 16 bits signed numbers (Q7.9).

State - 1 (Reset): 
Reset SRAMs to Zero. Wait for the next state button. No need to display anything on 7-segment displays. Display “Reset” on LCD.
State - 2 : 
Display “SRAM A  Input” on LCD. 
Input 4 hex values (16-bit FP number) from 4x4 Keypad, display them on 7-segment display and store it to the corresponding mem location of SRAM_A. In this state, user should be able to store FP numbers to all 8 mem locations.
State - 3 : 
Display “SRAM B  Input” on LCD. 
Input 4 hex values (16-bit FP number) from 4x4 Keypad, display them on 7-segment display and store it to the corresponding mem location of SRAM_B. In this state, user should be able to store FP numbers to all 8 mem locations.
State - 4 : 
Display “FP MAC Calc” on LCD. 
In each clock cycle, it should fetch one-one fixed point numbers from both SRAMs (starting from mem location 0), multiply them and accumulate the results of each pair. Display the final accumulated result in hex on 7-segment.
![image](https://user-images.githubusercontent.com/104184771/202356922-986a96bc-847b-4b7b-9678-7deaa7405482.png)


This project implements pipelining in Fixed Point Multiplier and Adder by dividing the calculation into Three stages.
1st stage- Multiplication of two Q7.9 number.
2nd  stage – Normalization (Saturation and Rounding and convert into Q7.9)
3rd stage – Addition and saturation (if saturated)
![image](https://user-images.githubusercontent.com/104184771/202357048-a307c4c3-b3d7-4ff8-8ea6-66e4092d77f3.png)
