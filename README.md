[![DOI](https://zenodo.org/badge/884527688.svg)](https://doi.org/10.5281/zenodo.14159967)  [![View GazeLab on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/175110-gazelab)
# GazeLab

GazeLab is a research toolkit for getting real-time eye-tracking data from EyeLink and updating stimulus location based on gaze coordinates. It provides tools to set up a simple experiment using Psychtoolbox, conversion between visual degree and pixel, designed to streamline experiments involving real-time gaze-contingent stimulus presentation.  

---
### Getting Started
#### Prerequisites
- Psychtoolbox (Download [here](http://psychtoolbox.org/download))
- EyeLink Developers Kit (Download [here](https://www.sr-research.com/support/thread-13.html))
  - You will need to create an account to access SR Support Forum
 
#### Tested on:
- MATLAB R2023b
- Psychtoolbox-3.0.19
- EyeLink Developers Kit v2.1.1197

#### Installation
1. Clone this repository:  
```
    git clone https://github.com/chanyca/GazeLab.git
```
2. Navigate to the project directory in MATLAB:
```
    cd('GazeLab')
```
---
### Key functions
`GazeLab_DrawStim`: Draw visual stimulus to on-screen window, target stimulus location contingent to gaze position.  
`GazeLab_MonitorGaze`: Real-time monitoring of gaze position, send on-screen warning if gaze is too far from fixation and target stimulus is out of bound.  
`GazeLab_FixationHelper`: Fixation helper for when target stimulus is out of bound, stimulus presentation resumes after 1s successful fixation.  

For a very simple demo of how the function tracks gaze and update stimulus location (no eye-tracker required), run `Demo.m`.

---
### Contributing
Contributions are welcome! Please submit a pull request or open an issue for any enhancements, bug fixes, or other suggestions.

---
### License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
