### Exercise 4: Create a NotHotDog app

In this exercise, you will use [Visual Studio Code](https://code.visualstudio.com/), Microsoft's free, cross-platform source-code editor which is preinstalled in the Data Science VM, to write a NotHotDog app in Python. The app will use [Tkinter](https://wiki.python.org/moin/TkInter), which is a popular GUI framework for Python, to implement its user interface, and it will allow you to select images from your local file system. Then it will pass those images to the model you trained in the previous exercise and tell you whether they contain a hot dog.

1. Click **Applications** in the upper-left corner of the desktop and select **Accessories > Visual Studio Code** to start Visual Studio Code. Use Visual Studio Code's **File > Open Folder...** command to open the "notebooks/tensorflow-for-poets-2/tf_files" folder containing the **retrained_graph_hotdog.pb** file created when you trained the model.

1. Create a new file named **classify.py** in the current folder. If Visual Studio Code offers to install the Python extension, click **Install** to install it. Copy the code below to the clipboard and use **Shift+Ins** to paste it into **classify.py**. Then save the file:

    ```python
    import tkinter as tk
    from tkinter import messagebox, filedialog, font
    from PIL import ImageTk, Image
    import subprocess

    def select_image_click(img_label):
        try:
            file = filedialog.askopenfilename()

            img = Image.open(file)
            img = img.resize((300, 300))
            selected_img = ImageTk.PhotoImage(img)

            img_label.configure(image=selected_img, width=240)

            output = subprocess.check_output(["python",
                "../scripts/label_image.py",
                "--graph=retrained_graph_hotdog.pb",
                "--image={0}".format(file),
                "--labels=retrained_labels_hotdog.txt"])

            highest = str(output).split("\\n")[3].split(" ")

            if len(highest) == 3:
                score = float(highest[2])
                is_hotdog = True
            else:
                score = float(highest[3])
                is_hotdog = False

            if score > 0.95:
                if is_hotdog:
                    messagebox.showinfo("Result", "That's a hot dog!")
                else:
                    messagebox.showinfo("Result", "That's not a hot dog.")
            else:
                messagebox.showinfo("Result", "Can't tell.")

        except FileNotFoundError as e:
            messagebox.showerror("File not found", "File {0} was not found.".format(e.filename))

    def run():
        window = tk.Tk()

        window.title("Hotdog or Not Hotdog")
        window.geometry('400x600')

        text_font = font.Font(size=18, family="Helvetica Neue")
        welcome_text = tk.Label(window, text="Hot Dog or Not Hot Dog", font=text_font)
        welcome_text.pack()

        instructions_text = tk.Label(window, text="\n\nUse a neural network built with Tensorflow\n"
            "to identify photos containing hot dogs")
        instructions_text.pack(fill=tk.X)

        select_btn = tk.Button(window, text="Select", bg="#0063B1", fg="white", width=5, height=1)
        select_btn.pack(pady=30)

        image_label = tk.Label(window)
        image_label.pack()

        select_btn.configure(command=lambda: select_image_click(image_label))
        window.mainloop()

    if __name__ == "__main__":
        run()
    ```

    They key code here is the call to ```subprocess.check_output```, which invokes the trained model by executing a Python script named **label_image.py** found in the "scripts" folder, passing in the image that the user selected. This script came from the repo that you cloned in the previous exercise.

1. Use your favorite search engine to find a few food images — some containing hot dogs, and some not. Download these images and store them in the location of your choice in the VM's file system.

1. Use Visual Studio Code's **View > Integrated Terminal** command to open an integrated terminal. Then execute the following command in the integrated terminal to run the app:

     ```bash
     python classify.py
     ```

1. Click the app's **Select** button and pick one of the hot-dog images you downloaded in Step 3. Wait for a message box to appear, indicating whether the image contains a hot dog. Did the model get it correct?

	> If you see error messages regarding a missing kernel driver in the terminal window when you process an image, you can safely ignore them. They result from the fact that the Data Science VM does not contain a virtual GPU.

    ![Selecting an image](../images/select-image.png)

    _Selecting an image_

1. Repeat the previous step using an image that doesn't contain a hot dog. Was the model right this time?

Continue feeding food images into the app until you're satisfied that it can identify images containing hot dogs. Don't expect it to be right 100% of the time, but do expect it to be right *most* of the time.