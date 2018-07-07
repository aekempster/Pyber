# Quote Bot

Create and deploy an application that tweets quotes from a list. You can use the starter files provided here or follow the instructions below for creating this application from scratch. If you choose to use the provided files you can skip *Setting Up Your Repository*, but don't forget to add a .gitignore containing your config.py before you commit and push any changes. 

## Instructions

### 1. Create a New Repository on GitHub
* Log into GitHub.com and create a new repository. Name it `quote_bot` or something similar.

* Initialize your repository with a README and a .gitignore file using Python.

* _If you are using the starter files provided_, proceed to the next step.

* _If you want to start from scratch_, skip the next step and begin at *2.b Setting Up Your Repository and Application From Scratch*


### 2.a Setting up Your Repository Using the Starter Files
* From the command line
  - Navigate to your projects directory
  - Clone your new repo
  - Change into the directory
  - Create a .gitignore file and add config.py by running the following command:
    - `echo config.py >> .gitignore`
  
* From the GUI:
  - Copy/paste the following files from the class repository into your `quote_bot` repository:
    - QuoteBot.ipynb
    - config.py
    - Procfile
    - requirements.txt
  - *Don't work out of the class repository!*
  
* Start your virtual environment and Jupyter Notebook and proceed to step 3.


### 2.b Setting Up Your Repository and Application From Scratch

* From the command line (Terminal on Apple, GitBash on Windows):
  - Clone your new repository.
  - Change into the directory.
  - To the .gitignore, add `config.py` by running the following command: 
    - `echo config.py >> .gitignore`
  - Start Jupyter Notebooks.

* Create a new text file. Rename it `Procfile` and add one line of text: `worker: python main.py`

* Create another text file and rename it `config.py`. Add your Twitter credentials. 

* Create one more text file and rename it `requirements.txt`. Add our only third-party dependency: `tweepy==3.5.0`
  
* Create a new notebook and rename it `main`.

* Your repository should now contain six files: 
  - main.ipynb
  - config.py
  - Procfile
  - requirements.txt
  - README.md
  - .gitignore


### 3. Writing the Application

In your notebook:

* Import dependencies

* Set up Twitter credentials

* Create a list (of at least three) of your favorite quotes

* Define a function to tweet each quote in your list

* Print a success message

* Set timer to run your quote function every minute

Once your application is running locally, add, commit and push the changes to your remote repository.


### 4. Deploy to Heroku

* Log into Heroku.com and create a new app. Give it a memorable name. 

* From the dashboard, select Settings.
  - Under Config Vars, select `Reveal Config Vars`
  - Add your Twitter credentials, using the variables referenced by os.environ in your notebook: 
  ```
  CONSUMER_KEY
  CONSUMER_SECRET
  ACCESS_TOKEN
  ACCESS_TOKEN_SECRET
  ```

* From the dashboard, select Deploy. Under Deployment Method, select GitHub.
  - Under App connected to GitHub, search for your `quote_bot` repo.
  - Under Automatic deploys, select `Enable Automatic Deploys`
  - Under Manual deploy, select `Deploy Branch` with `master` selected. 

* From the dashboard, select Resources.
  - Under Free Dynos, select the pen icon on the far right to enter edit mode.
  - Slide the toggle switch to the on position. 
  - Click the edit button to commit changes.
