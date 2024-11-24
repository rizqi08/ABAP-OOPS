*****           Implementation of object type ZEMPLOYEE            *****
INCLUDE <OBJECT>.
BEGIN_DATA OBJECT. " Do not change.. DATA is generated
* only private members may be inserted into structure private
DATA:
" begin of private,
"   to declare private attributes remove comments and
"   insert private attributes here ...
" end of private,
      KEY LIKE SWOTOBJID-OBJKEY.
END_DATA OBJECT. " Do not change.. DATA is generated

BEGIN_METHOD CREATE CHANGING CONTAINER.
DATA:
      PEMPLOYEE LIKE ZBAPI_EMPLOYEE_10,
      RETURN LIKE BAPIRET2.
  SWC_GET_ELEMENT CONTAINER 'Pemployee' PEMPLOYEE.
  CALL FUNCTION 'ZBAPI_EMPLOYEE_CREATE'
    EXPORTING
      PEMPLOYEE = PEMPLOYEE
    IMPORTING
      RETURN = RETURN
    EXCEPTIONS
      OTHERS = 01.
  CASE SY-SUBRC.
    WHEN 0.            " OK
    WHEN OTHERS.       " to be implemented
  ENDCASE.
  SWC_SET_ELEMENT CONTAINER 'Return' RETURN.
END_METHOD.
