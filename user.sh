echo LOCAL_UID=`id | sed -e 's/^uid=\(.*\)(\(.*\)) gid=.*$/\1/'` > .user.env
echo LOCAL_GID=`id | sed -e 's/uid=.* gid=\(.*\)(\(.*\)) groups=.*/\1/'` >> .user.env
