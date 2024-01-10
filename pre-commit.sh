#!/bin/sh

which ./vendor/bin/phpcs &> /dev/null
if [ $? -eq 1 ]; then
  echo "Please install PHPCS"
  exit 1
fi

which ./vendor/bin/phpstan &> /dev/null
if [ $? -eq 1 ]; then
  echo "Please install PHPSTAN"
  exit 1
fi

which ./vendor/bin/phpunit &> /dev/null
if [ $? -eq 1 ]; then
  echo "Please install PHPUNIT"
  exit 1
fi

./vendor/bin/phpcs -s

if [ $? -eq 0 ]; then
  echo "PHPCS Passed!"
else
  echo "PHPCS Failed!"
  exit 1
fi

php -d memory_limit=-1 vendor/bin/phpstan analyse pkg test

if [ $? -eq 0 ]; then
  echo "PHPSTAN Passed!"
else
  echo "PHPSTAN Failed!"
  exit 1
fi

php vendor/bin/phpunit

if [ $? -eq 0 ]; then
  echo "PHPUNIT Passed!"
else
  echo "PHPUNIT Failed!"
  exit 1
fi

echo "COMMIT SUCCEEDED"

exit 0