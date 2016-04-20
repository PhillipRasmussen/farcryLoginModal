# farcryLoginModal
While in the webtop editing content if your session times out you won't know untill you try to save your work. At that point you will loose any changes from the last successful save.

This plugin will poll farcry every 6 seconds while there is activity on the window (eg mouse movement, scrolling, keyboard down) to see if you're still logged in. This activity will keep the seesion active. 

If activity is detected and you're not logged in, it will produce a modal over all other modals with the login view. 
Once sucessfully logged in again it will hide the modal and not refresh the page allowing you to continue. 