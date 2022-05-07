LOCAL_UID=`id | sed -e 's/^uid=\(.*\)(\(.*\)) gid=.*$/\1/'`
LOCAL_GID=`id | sed -e 's/uid=.* gid=\(.*\)(\(.*\)) groups=.*/\1/'`
