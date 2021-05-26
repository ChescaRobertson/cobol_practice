       IDENTIFICATION DIVISION.
       PROGRAM-ID. fizzbuzz.
       DATA DIVISION.
           WORKING-STORAGE SECTION.
           01 WS-NUM UNSIGNED-INT. 
       PROCEDURE DIVISION.
           DISPLAY "Choose your number: ".
           ACCEPT WS-NUM.
           IF FUNCTION MOD (WS-NUM, 3) = 0 AND FUNCTION MOD (WS-NUM, 5)
      -    = 0 
               DISPLAY "FizzBuzz"
           ELSE IF FUNCTION MOD (WS-NUM, 3) = 0
               DISPLAY "Fizz"
           ELSE IF FUNCTION MOD (WS-NUM, 5) = 0
               DISPLAY "Buzz"
           ELSE 
               DISPLAY WS-NUM
           END-IF.

           

