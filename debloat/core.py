import os
import questionary
from rich.console import Console
from utils.ps_runner import run_ps_script

script_dir = os.path.join(os.path.dirname(__file__), 'powershell')

debloat_actions = [
    {"name": "Remove OneDrive", "script": "remove_onedrive.ps1"},
    {"name": "Deactivate Telemetry", "script": "remove_telemetry.ps1"},
    {"name": "Remove Microsoft Edge", "script": "remove_edge.ps1"},
    {"name": "Remove Xbox Apps", "script": "remove_xbox.ps1"},
    {"name": "Remove/Deactivate Cortana", "script": "remove_cortana.ps1"},
    {"name": "Remove 3D Viewer", "script": "remove_3dviewer.ps1"},
    {"name": "Remove Skype", "script": "remove_skype.ps1"},
    {"name": "Deactivate News & Interests", "script": "remove_news.ps1"},
    {"name": "Remove Preinstalled Office Apps", "script": "remove_office_apps.ps1"},
    {"name": "Remove Maps App", "script": "remove_maps.ps1"},
    {"name": "Deactivate Windows Defender", "script": "disable_windows_defender.ps1"},
    {"name": "Deactivate Bing Search", "script": "remove_bing_search.ps1"},
    {"name": "Deactivate People Bar", "script": "remove_people.ps1"},
    {"name": "Remove Feedback Hub", "script": "remove_feedback_hub.ps1"},
    {"name": "Remove Solitaire Collection", "script": "remove_solitaire.ps1"},
    {"name": "Run All (Recommended!)", "script": None}  # Special action to run all scripts
]

def main_menu(console: Console):
    while True:
        options = [action["name"] for action in debloat_actions] + ["Exit"]
        answer = questionary.select("Select an action:", choices=options).ask()
        if answer == "Exit" or answer is None:
            break
        if answer == "Run All (Recommended!)":
            for action in debloat_actions[:-1]:
                script_path = os.path.join(script_dir, action["script"])
                run_ps_script(console, script_path, action["name"])
        else:
            action = next(a for a in debloat_actions if a["name"] == answer)
            script_path = os.path.join(script_dir, action["script"])
            run_ps_script(console, script_path, answer)
