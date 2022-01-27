find . -type f -exec grep --include=\*.java -rnw '.' -e 'seed' {} \;
