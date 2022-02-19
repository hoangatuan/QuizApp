# Contents
- TDD
- Test Flow
- Integration Test

# TDD
 ```Red - green - refactor```
 
- Write test first.
- Write only enough code to make the test pass.
- Refactor test case, logic code.

> Note: Don't need to test private func -> test private func through public func

# Test flow
- setup
- run test
- teardown

# Integration Test
- Only need to test public API (only import Module need to use, don't import @tesable if not need).
