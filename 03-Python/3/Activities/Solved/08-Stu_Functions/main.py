# -*- coding: UTF-8 -*-
"""Average Numbers."""


def average(numbers):
    """Calculate the average for a list of numbers.

    Args:
        numbers (list): A list of integers.

    Return:
        The average value for a list of numbers.

    """
    length = len(numbers)
    sum = 0.0
    for number in numbers:
        sum += number
    return sum / length


def main():
    """main function."""
    print(average([1, 5, 9]))
    print(average(range(11)))

if __name__ == "__main__":
    main()
