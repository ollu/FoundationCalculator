## Global setup:
Download and install [Git](http://git-scm.com/download)

	git config --global user.name "Your Name"
	git config --global user.email your.email@server.com
## Next steps:
	mkdir ProjectName
	cd ProjectName
	git init
	touch README
	git add README
	git commit -m 'first commit'
	git remote add origin git@github.com:ollu/ProjectName.git
	git push -u origin master

## Existing Git Repo?
	cd existing_git_repo
	git remote add origin git@github.com:ollu/ProjectName.git
	git push -u origin master
## Importing a Subversion Repo?
[Read this](https://github.com/ollu/FoundationCalculator/imports/new)

## Resources
[git community book](http://book.git-scm.com/)  
[Pro Git](http://progit.org/book/)