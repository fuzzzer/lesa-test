
import os
from gtts import gTTS

sentences = [
    "The fox.",
    "The fox found a stone",
    "The fox began a journey"
]

script_dir = os.path.dirname(os.path.abspath(__file__))
output_dir = os.path.join(script_dir, "outputs")

os.makedirs(output_dir, exist_ok=True)

file_paths = []

for idx, sentence in enumerate(sentences, start=1):
    tts = gTTS(sentence)
    file_name = f"page_{idx}.mp3"
    file_path = os.path.join(output_dir, file_name)
    tts.save(file_path)
    file_paths.append(file_path)

print("Generated MP3 files in:", output_dir)
for path in file_paths:
    print(path)
