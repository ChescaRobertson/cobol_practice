       IDENTIFICATION DIVISION.
       PROGRAM-ID. "test-subtract".
       DATA DIVISION.
           WORKING-STORAGE SECTION.
           01 LS-SUM UNSIGNED-INT.
       PROCEDURE DIVISION.
           CALL "subtract" USING 4 3 LS-SUM.
           CALL "assert-equals" USING LS-SUM 1.
