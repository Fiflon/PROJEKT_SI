import tkinter as tk
from tkinter import messagebox, ttk

import clips

DEBUG = True

MAX = 7
WIDTH = 900
HEIGHT = 600

env = clips.Environment()
env.load("clipsd.clp")
env.reset()
env.run()

msg_template = env.find_template("pytanie")
message = dict(list(msg_template.facts())[0])

if DEBUG:
    print(message)


class App:
    def __init__(self, root):
        self.root = root
        self.root.title("GREAT BOOKS")
        self.root.geometry(f"{WIDTH}x{HEIGHT}")

        self.message = message
        self.radio_var = tk.IntVar(value=-1)

        self.question_label = ttk.Label(
            root, text=self.message["question"], font=("Helvetica", 18)
        )
        self.question_label.pack(pady=10)

        self.radio_buttons = []
        self.text_labels = []

        options = self.message["answers"]
        for i in range(MAX):
            frame = ttk.Frame(root)
            frame.pack(anchor="w", padx=20, pady=5)

            radio_button = ttk.Radiobutton(frame, variable=self.radio_var, value=i)
            radio_button.pack(side="left")
            self.radio_buttons.append(radio_button)

            text_label = ttk.Label(
                frame,
                text=options[i] if i < len(options) else "",
                font=("Helvetica", 16),
            )
            text_label.pack(side="left")
            self.text_labels.append(text_label)

            if i >= len(options):
                frame.pack_forget()

        self.submit_button = ttk.Button(root, text="Submit", command=self.submit)
        self.submit_button.pack(pady=20)

    def submit(self):
        selected_index = self.radio_var.get()
        self.radio_var.set(-1)
        if selected_index == -1:
            messagebox.showwarning("No Selection", "Please select an option.")
            return

        selected_answer = self.message["answers"][selected_index]
        print(selected_answer, self.message["name"])
        env.assert_string(f'({self.message["name"]} "{selected_answer}")')
        env.run()
        env.eval("(facts)")

        message_list = list(msg_template.facts())
        if message_list:
            self.message = dict(message_list[0])
            if DEBUG:
                print(self.message)
            self.update_question_and_answers()
        else:
            self.root.withdraw()
            self.show_result()

    def update_question_and_answers(self):
        self.question_label.config(text=self.message["question"])
        options = self.message["answers"]

        for i in range(MAX):
            if i < len(options):
                self.radio_buttons[i].pack(side="left", padx=5, pady=5)
                self.radio_buttons[i].configure(state="normal")
                self.text_labels[i].pack(side="left", padx=5)
                self.text_labels[i].config(text=options[i])
            else:
                self.radio_buttons[i].pack_forget()
                self.text_labels[i].pack_forget()

    def show_result(self):
        res_template = env.find_template("book")
        try:
            result = dict(list(res_template.facts())[0])
        except IndexError:
            messagebox.showerror("Error", "No book was found.")
            self.root.destroy()
            return

        result_window = tk.Toplevel()
        result_window.title("Discovered Book")
        result_window.geometry(f"{WIDTH}x200")

        ttk.Label(result_window, text=result["title"], font=("Helvetica", 20)).pack(
            pady=10
        )
        ttk.Label(result_window, text=result["author"], font=("Helvetica", 15)).pack(
            pady=10
        )

        def close_app():
            result_window.destroy()
            self.root.destroy()

        ttk.Button(result_window, text="Close", command=close_app).pack(pady=30)


root = tk.Tk()
app = App(root)
root.mainloop()
