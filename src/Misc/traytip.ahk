; EXAMPLE #3: This is a working script that demonstrates some of the various menu commands.

#Persistent
#SingleInstance
menu, tray, add ; separator
menu, tray, add, TestToggle&Check
menu, tray, add, TestToggleEnable
menu, tray, add, TestDefault
menu, tray, add, TestStandard
menu, tray, add, TestDelete
menu, tray, add, TestDeleteAll
menu, tray, add, TestRename
menu, tray, add, Test
menu, tray, tip,  u fawka wat `ndisfaka `n NO YOU  
return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TestToggle&Check:
menu, tray, ToggleCheck, TestToggle&Check
menu, tray, Enable, TestToggleEnable ; Also enables the next test since it can't undo the disabling of itself.
menu, tray, add, TestDelete ; Similar to above.
return

TestToggleEnable:
menu, tray, ToggleEnable, TestToggleEnable
return

TestDefault:
if default = TestDefault
{
    menu, tray, NoDefault
    default =
}
else
{
    menu, tray, Default, TestDefault
    default = TestDefault
}
return

TestStandard:
if standard <> n
{
    menu, tray, NoStandard
    standard = n
}
else
{
    menu, tray, Standard
    standard = y
}
return

TestDelete:
menu, tray, delete, TestDelete
return

TestDeleteAll:
menu, tray, DeleteAll
return

TestRename:
if NewName <> renamed
{
    OldName = TestRename
    NewName = renamed
}
else
{
    OldName = renamed
    NewName = TestRename
}
menu, tray, rename, %OldName%, %NewName%
return

Test:
MsgBox, You selected "%A_ThisMenuItem%" in menu "%A_ThisMenu%".
return