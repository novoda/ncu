# About Testing & Refactoring
> On testing and refactoring code

Code written for consumer applications (such as mobile apps) is never a static entity. Requirements and designs often change many times midway through development and, even when they don’t, there’s never any guarantee that the code written will work as expected  because errors (bugs) do happen, no matter how experienced and knowledgeable the developers are.

That is why we should always write the best code possible. Testing and Refactoring are developers tools that helps us write code with as little bugs as possible. 

In this module we will look into how TDD helps us catch possible bugs before putting code in production, and how refactoring helps us keep a bug free environment while fixing problems, writing features and accounting for design changes. All of this should be done whilst maintaining good, clean code.   

## Test-Driven Design (TDD)

> "Test-driven development (TDD) is an evolutionary approach to development which combines test-first development where you write a test before you write just enough production code to fulfil that test and refactoring.  The goal of TDD is specification and not validation, In other words, it’s a way to think through your requirements or design before your write your functional code" - Agile Data

TDD is useful when writing new code, as it allows you to investigate requirements before it is production code. However, refactoring old code is just as important. 

Code refactoring is the art and science of changing your code in a controlled manner making the codebase more resilient against future bugs while also making it more flexible and amenable to future design changes.

This will take some time to *read* code you have not written. It is a skill in itself to be able to read and understand other people's code. It takes time to practice and patience to learn and understand what another developer was thinking as they wrote that spaghetti ball you are untangling - it mustn't have felt like spaghetti at the time and this is what you need to understand before you can be confident enough to make changes. 

## Literature

Below are some books/resources on TDD and refactoring: 

- **Growing Object-Oriented Software: Guided by Tests** by Steve Freeman, Nat Pryce
- **Refactoring** by Martin Fowler
- **Working Effectively with Legacy Code** by Michael C. Feathers

## Guidelines

Some guidelines for making the most of feedback and learning in this part of the NCU include: 

- Apply your learnings to a piece of code: for instance you could contribute new code, or find some code you are not familiar with and look for areas to improve.
- Your colleagues should have easy access to your work: prefer to have your project on a hosted repo, for example Github or BitBucket. 
- Ensure someone viewing your project can easily understand what you’re trying to achieve: document your goal as part of your work
- The code should look familiar to your reviewers: ensure you follow Novoda’s style guidelines (see [https://github.com/novoda/novoda/tree/master/style-guides]()).
- Progress should be iterative and well documented: you should issue at least one PR that someone else should review.
- Organise a [coding kata](http://codekata.com), around one of the topics you found most interesting in this module.

Remember, your buddy can always help you with any of the points above.


## Progress log

The following are the ‘check-boxes’ items


- [ ] Find an appealing resource from which you can learn something new on testing or refactoring

- [ ] Practice testing and refactoring techniques on some code

- [ ] Get feedback from your peers 

- [ ] Organise a coding kata about testing or refactoring
