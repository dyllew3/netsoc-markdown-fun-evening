---
title: Integer Spiral Sillines
subtitle: A report
author: Andrew Shaw <shawa1@tcd.ie>
date: \today
abstract: |
  We present a coordinate space for addressing elements on the Integer Spiral
  which is rotationally symmertric $90\deg$ about the origin. We develop and
  present useful supporting formulae, in terms of some integer $n$, for computing
  the coordinates of $n$ in this space, with a view to computing the $\ell_1$
  (taxicab) distance from $n$ to the origin.
...

# Introduction
We define a Spiral over some ordered set $S$ to be an arrangement of the
elements of $S$ in an $N \times N$ grid - where $N$ is odd - such that the least
element of $S$ is in the centre, with the elements arranged in a
counter-clockwise fashion, spiralling outward from the centre.

An example of one such Spiral is the Spiral over the Natural numbers, which we
will denote as $\mathcal{N}$.

## Shells in the Spiral

When dealing with elements in $\mathcal{N}$, it will prove useful to partition
$\mathcal{N}$ into subsets radiating outward from the origin, which we will call
_shells_, denoted as $S_n$, where $n$ is the number of shells between $S_n$ and
the origin.

```c
did someone() {
   say *code = blocks & high : lighting ? "NO PROBLEM!";
}
```

## Boundary numbers
We define the _boundary number_ of a shell to be the greatest number in that
shell, so-called as it marks the boundary between two successive shells when
following the spiral from the center.
