---
title: "Rust vs Python in the Dimensionality of Certainty"
description: "Choosing Rust or Python for a project."
draft: false
date: 2023-08-12T13:13:09-04:00
tags: ["software engineering", "rust", "python"]
---

Choosing the right tool to do the job can be hard. Recently, the two programming languages that I have been using are Python and Rust. I believe that, with these two languages, I can solve a vast majority of the problems I wish to solve (especially if you throw some js/ts into the mix). Rust and Python are very different languages. Rust is compiled and Python is interpreted. Rust is statically typed and Python is dynamically typed. Rust is a system level programming language and Python is a high level programming language.

I would like to explain, when starting a new project, why I would choose one over the other. If we are talking performance, Rust wins by a long shot - end of discussion. However, I do think a discussion of just performance is missing the point. As a person that works at a startup, I think an interesting dimension to explore when choosing is technology is certainty (thanks to [Theo ](https://www.youtube.com/@t3dotgg) for getting me to think about this dimension in the first place). In startup land, certainty can be considered how sure you are that you're building the right solution or even if anyone will care to use your product at all. With low certainty, it’s better to optimize for speed to change. The graph below is a visual reference to my thinking on this topic. The x axis represents low to high certainty and the y represents low to high performance. We can define performance, for this discussion, as processing speed, memory usage, and safety or how likely something is to fail in production (I could have pulled safety into its own dimension but for simplicity sake I wanted to draw a 2D graph).

![Graph of rust vs python](rust-vs-python.png)

Starting in the bottom left, where certainty is low and performance is not as important, this quadrant is where I believe Python dominates. The ability to get something working fast is not rivaled by many languages. A quick script, a Jupyter notebook or even the REPL (Read-Eval-Print Loop). The iteration speed is superfast. Moving more towards the center of the graph, this is where I believe that well tested Python applications lay.

On the opposite side of the spectrum is where certainty is high and performance is critical. This is where Rust dominates. Most of the time, you can get similar performance to C, with Rust. Rust also has safety guarantees due to the borrow checker and its use of errors as values. These factors make Rust one of the best choices for high performance requirements and high certainty. This is where highly scalable applications with already known requirements lay. For example, when planning to write some software that will live on our (my current employer's) IoT cellular modem, we decided to go with Rust. We decided to go with Rust because of the limitation of the modem's hardware (i.e., the need for performance). Also, when releasing software running on hardware that is pushed over the air, the certainty needs to be higher than some service deployed to AWS that can be rolled back in a matter of minutes.

In the bottom right of the graph, where certainty is high and performance is not critical, this is where things that should not fail lay. This is where type hinted Python and Rust, with its safety guarantees stated above, are best.

Where certainty and performance is critical in the top left corner of the graph, there are two best options, in my opinion. You can pull out performance critical parts of your application to Rust using [PyO3](https://github.com/PyO3/pyo3) and still write most of the application in Python. Or you can use unwrap on most result and option types. Although I love the results and option types in Rust for prototypes or creating software fast, it can be verbose and tedious to handle properly. Using unwrap to only focus on the happy path can make building software in Rust a lot faster.
