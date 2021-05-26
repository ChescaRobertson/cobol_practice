       IDENTIFICATION DIVISION.
       PROGRAM-ID. add.
       DATA DIVISION.
           LINKAGE SECTION.
      *    We use it to specify the variables this program can receive
      *    from other programs calling it     
           01 LS-NUM-1 UNSIGNED-INT.
           01 LS-NUM-2 UNSIGNED-INT.
           01 LS-SUM UNSIGNED-INT.

      * Our Procedure division is different this time.
      * We specify the variables this program should be given with USING.
       PROCEDURE DIVISION USING LS-NUM-1, LS-NUM-2, LS-SUM.
           COMPUTE LS-SUM = LS-NUM-1 + LS-NUM-2.
      *    COMPUTE performs arithmetic calculations for us.
