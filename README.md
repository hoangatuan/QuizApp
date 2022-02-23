# Contents
- TDD
    - Test Flow
    - Integration Test
    - Technique
        - Mutation testing
        - Refactoring
        - Private extension
        - Fix bug with TDD
    - Note
        
- Modular Architecture
    

# TDD
 ```Red - green - refactor```
 
- Write test first.
- Write only enough code to make the test pass.
- Refactor test case, logic code.

> Note: 
- Don't need to test private func -> test private func through public func.
- Every time you notice that something is hard to test, you are probably dealing with a complicated design that might require some extra thinking. Simplify it!

## Test flow
- setup
- run test
- teardown

## Integration Test
- Only need to test public API (only import Module need to use, don't import @tesable if not need).

## Technique
### Mutation Testing

### Refactoring
- Use factory methods like `makeSUT()` ... -> 
    - only have to change the test factory method if need, leaving the tests free from change in the future.
    - tests become lighter, less fragile and more readable. 

### Private extension in test module.
    
### Fix bug with TDD
-  write a test that replicates the unwanted behavior. (added a missing test case)
- write the production code needed to make the test pass.

## Note
- Class A use method of class B ->
    - Write test case for method of class B. (verify B.result == B.expectResult)
    - Write test to verify if A use result of method B (verify A.result == B.result, not A.result == B.expectResult)

# Modular Architecture
- It's important to separate presentation logic and UI logic
    -> easier to test, maintain and reuse.
- should strive to create solutions that don't tie us down to specific platforms or frameworks.
- Should make module flexible by using generics & protocol.

