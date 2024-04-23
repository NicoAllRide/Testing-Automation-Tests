*** Settings ***
Library    Process

*** Variables ***
${K6_SCRIPT}    ./test.js

*** Test Cases ***
Run Load Test
    ${result} =    Run Process    k6 run ${K6_SCRIPT}
    Should Be Equal As Integers    ${result.rc}    0    # Verificar si la ejecución fue exitosa
    Log    Load test result: ${result.stdout}
