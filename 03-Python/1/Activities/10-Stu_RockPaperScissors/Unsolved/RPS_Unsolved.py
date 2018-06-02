# Incorporate the random library
import random

# Print Title
print("Let's Play Rock Paper Scissors!")

# Specify the three options
options = ["r", "p", "s"]

# Computer Selection
computer_choice = random.choice(options)

# User Selection
user_choice = input("Make your Choice: (r)ock, (p)aper, (s)cissors? ")

# Run Conditionals

if user_choice == computer_choice:

    print("No winner")

if user_choice == "r" and computer_choice == "s":

   print("computer is the winner.")

if user_choice == "s" and computer_choice == "r":

   print("user is the winner.")


if user_choice == "s" and computer_choice == "p":

   print("user is the winner.")


if user_choice == "p" and computer_choice == "s":

   print("computer is the winner.")


if user_choice == "r" and computer_choice == "p":

   print("user is the winner.")


if user_choice == "p" and computer_choice == "r":

   print("computer is the winner.")