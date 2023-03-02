#!/bin/sh

# web: will run as website, if web.config is present use info from that
appDll=$(grep -so -E '([^\"]*)\.dll' web.config)
if [ ! $appDll ]
then
  # app: find any executable, assume main dll has same name
  app=$(find . -type f -perm -u+x)  
  if [ $app ]
  then
    appDll="$app.dll"
  fi
fi

# todo: support for enforcing ownership of non-root user?

# no dll found?
if [ ! $appDll ] || [ ! -f $appDll ]
then
  notFound=$([ $appDll ] && echo "Identified main dll as $appDll, however it was not found.")
  echo -e "Unable to autostart application dll (alpine will not execute binary). $notFound\n"
  echo "Listing files present in $PWD:"
  ls .
  echo -e "\nYou can start the application manully using: dotnet [ dll-name ]"
  return
fi

# start dll
dotnet $appDll
