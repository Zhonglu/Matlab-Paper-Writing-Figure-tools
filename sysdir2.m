function sysdir2

    sys=computer;
    if sys(1:6)=='MACI64'
        %cd '/Volumes/GROUP_BLACK/orange_backup/'
        %cd '/Users/zhonglulin/Documents/OneDrive - University Of Cambridge/OneDrive/PhDWorks/VIV/'
        %cd '/Volumes/GROUP_BLACK/Independent_part_2/'
        cd '/Volumes/My Passport/damped_cases_Independent_part_3/'
        %cd '/Volumes/My Passport/Free_cylinder/'
    else
        %cd D:\Independent_23_Dec %Re=100 data
        cd D:\damped_cases_Independent_part_3  %Re varied data, Group Black
        %cd E:\free_cylinder 
    end

end