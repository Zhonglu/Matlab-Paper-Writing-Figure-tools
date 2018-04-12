%%Purge certain files for directory recursively

function purge(fdir)
stop

cd(fdir)

delete('0*.DAT')
delete('./test.e')



end