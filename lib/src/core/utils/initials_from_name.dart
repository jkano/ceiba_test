String getInitialsFromName(String name) => name.isNotEmpty
    ? name.trim().split(' ').map((letter) => letter[0]).take(2).join()
    : '';
