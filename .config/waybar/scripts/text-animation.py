#!/usr/bin/env python3

import random
import time
import json
from pathlib import Path

def load_messages(filepath: Path | str) -> list[str]:
    filepath = Path(filepath)
    
    if not filepath.exists():
        return ['File messages nggak ketemu!']

    with open(filepath, 'r') as file:
        return [line.strip() for line in file 
                if line.strip() and not line.startswith('!')]

def print_to_console(msg: str, alt: str) -> None:
    text = {'text': msg, 'tooltip': msg, 'alt': alt, 'class': alt}
    print(json.dumps(text), flush=True)


def typing(msg: str, type_speed: float |int = 0.3, pause: float| int = 3) -> None:
    length = len(msg) + 1 
    sequence = [(i, 'write') for i in range(length+1)] + \
               [(i, 'delete') for i in range(length -1, -1, -1)]
    for char_idx, status in sequence:
        print_to_console(msg[:char_idx], status)
        
        if char_idx == length:
            time.sleep(pause)
        else:
            time.sleep(type_speed)


def main() -> None:
    import sys
    from itertools import cycle
    try:
        filepath = Path(__file__).parent / 'messages'

        messages = load_messages(filepath)
        print(messages)
        random.shuffle(messages)

        for msg in cycle(messages):
            typing(msg)
    except KeyboardInterrupt:
        sys.exit()

if __name__ == '__main__':
    main()