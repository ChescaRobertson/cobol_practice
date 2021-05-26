       IDENTIFICATION DIVISION.
       PROGRAM-ID. "test-birthday-checker".
       DATA DIVISION.
           WORKING-STORAGE SECTION.
           01 WS-BIRTHDAY-GREETER PIC A(40).
       PROCEDURE DIVISION.

       IF-TODAY-IS-BIRTHDAY.
           CALL "birthday-checker" USING "Jim", 0526, 0526 WS-BIRTH
      -    DAY-GREETER.
           CALL "assert-equals" USING "Happy Birthday Jim" WS-BIRTHDAY-
      -    GREETER.

       IF-TODAY-IS-NOT-BIRTHDAY.
           CALL "birthday-checker" USING "Jim", 0726, 0526, 
           WS-BIRTHDAY-GREETER.
           CALL "assert-equals" USING "It is not your birthday" WS-BIRTH
      -    DAY-GREETER.


