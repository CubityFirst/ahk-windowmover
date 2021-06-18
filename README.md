# AutoHotkey Window Mover

This code was originally based off of AntVenom's Window Mover script that he shared a couple years ago, but modified by me, for my purposes and stored here for the sake of keeping it publicly accessible & easy to use.

This checks if an application is open, if it is open. Then move it to the correct location. The exception to this is apps like Spotify, where it might close the application, create a new one, and then move it. 

⚠ If you want to run this, **You will have to modify it yourself,** to suit *your* resolution and *your* applications.

Some tips - If you want to get Window ID's, Window Sizes, Process names or more, consider using [ShareX](https://getsharex.com)'s Inspect Window tool, it was incredibly useful when I was creating this.

<img src="https://i.imgur.com/2wzg86Q.png" style="zoom: 67%;" />

### Weird Quirks

------

I'm not sure if it's an issue with AHK, or the script itself, but sometimes the coordinates of some of the programs are 5-6 pixels out of where they should be. After some thinking, I think that this includes the drop shadow around edges of programs, but this isn't something that I've tested.

Spotify, and Streamlabels seem to have this weird quirk, where you need to get the ID of the process window in a slightly round about way, there's included code for how to deal with that, and should be good to copy paste in those cases just with Tweaks.
