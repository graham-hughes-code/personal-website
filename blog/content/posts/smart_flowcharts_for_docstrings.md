---
title: "Smart flowcharts For Docstrings"
description: "Concept for flowcharts in Docstrings"
draft: true
date: 2023-03-16T20:58:13-04:00
tags: ["software engineering", "python"]
---

I currently work on a cross functional engineering team that involves other engineering disciplines (not software engineering).
Although these engineers do understand code, flowcharts seem to be more of a universal language for all engineering disciplines.
Flowcharts are easier for end users and non technical members of a business to understand, as well as a great way to explore solutions with other software engineers before writing the software.

I have made flowcharts for much of the software that I have written.
Over time as the software changes (as most software does), the reality of what is happening in the code and what is displayed in the flowchart drift apart.
If I want to reference the flowchart for a suggested change to a workflow or something of the like, I find that I have to spend a decent amount of time playing “[Spot the difference](https://en.wikipedia.org/wiki/Spot_the_difference)” between the code and the flowchart.
At worst, the drift is so bad that it's worth starting from scratch.

One solution to this issue is to have the flowcharts embedded directly into the dostrings of a given function. The reason I think that this is the best solution is twofold. It is the closest that you can get to the implementation of the logic that you're trying to describe with the flowchart. This means playing “Spot the difference” when changing the flowchart and being able to update the flowchart upon changes to the implementation can be remedied. This leads to hopefully less drift between the code and the flowchart.

This solution I believe should be able to go even further and be able to “compile” these flowcharts together to create a full flowchart for a file or package.
This would allow for a “grand overview” of all of the code for others to see.

I have made a prototype in python that does what I have discussed in this post.
It can be found [here](https://github.com/graham-hughes-code/pyflow).

## Example:
for the given file palindrome.py
```python

def isPalindrome(str):
  """
  check if string is isPalindrome

  Args:
    str (String):
  

  Returns:
    Boolean: True if the str is a Palindrome

  flowchart:
    S[reverse input str] --> X{reversed_str == str}
    X -- true --> N[return True]
    X -- false --> M[return False]
  """
  str_reversed = str[::-1]
  return str == str_reversed


def main():
  """
  main of program
  
  flowchart:
    A((Start)) --> B[\Get user input\]
    B --> C[Check if Palindrome]
    C -.-> isPalindrome
    C -- true --> D[Write str is a Palindrome]
    C -- true --> E[Write str is a Palindrome]
  """
  s = input('Enter string\n')
  ans = isPalindrome(s)
  
  if ans:
    print(f"{s} is a Palindrome")
  else:
    print(f"{s} is not a Palindrome")

if __name__ == "__main__":
  main()
```

If you run:
```shell
python pyflow .\palindrome.py
```

The output will be:
```
flowchart TD
subgraph isPalindrome
S[reverse input str] --> X{reversed_str == str}
X -- true --> N[return True]
X -- false --> M[return False]
end
subgraph main
A((Start)) --> B[\Get user input\]
B --> C[Check if Palindrome]
C -- true --> D[Write str is a Palindrome]
C -- true --> E[Write str is a Palindrome]
end
C -.-> isPalindrome
```
![flowchart](flowchart.PNG)

Output can be view by using the [mermaid Live Editor](https://mermaid.live/) or
[the mermaid cli](https://github.com/mermaid-js/mermaid-cli) or rendered in a github README.