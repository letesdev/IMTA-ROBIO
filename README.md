# IMTA-ROBIO-Electric-Sense-Simulator

<div align="center">
<img src=assets\essais\6_objets\6_objets.png height="300px" width="auto">
<br>
<img src=assets\Matlab-f17207.svg height="auto" width="auto">
</div>

## About

This repository is an educational purpose software. This software was an Engineering School Project within _Robotique bio-inspirée_ subject ([IMT Atlantique](https://www.imt-atlantique.fr/fr), programmed in Semester 6).

### State-Of-The-Art (SOTA)

**Bio-inspiration**, also known as **nature-based innovation**, is a field that involves drawing inspiration from solutions found in biological evolution and nature’s refinement over millions of years. It aims to develop new materials, devices, and structures by emulating nature’s principles and key features.
Unlike artificial intelligence (AI), which draws inspiration from the human brain to develop learning methods, bio-inspiration focuses on replicating design principles and observed characteristics from nature.

In the context of robotics, bio-inspiration seeks to equip robots with autonomy by taking inspiration from animals. This means giving robots the ability to perceive, interpret, decide, and act upon their environment without external intervention. One fascinating example of bio-inspiration is **electrolocation**.

This approach is inspired by electric fish such as *Gymnotiformes* and *Mormyrids*. In these fish, **electric discharges are used for navigation, detection, and prey capture, especially at night and in murky waters**. There are two modes of electric sensing:
- Active electrolocation: Some fish generate electric discharges using specialized muscles (myogenesis) or nerve cells (neurogenesis).
- Passive electrolocation: Other fish do not generate electric discharges but detect electrical signals from an external source.


<figure>
    <img src="doc\img\poisson_champ.png"
         alt="poisson_champ">
    <figcaption>Photo of the fish <em>Gnathonemus petersii</em> (a) and the electric field around the body of the fish (b), extracted from reference [4].</figcaption>
</figure>

### Work

The main objective of this work is to **create a simulator for the 2D navigation of a fish in an aquarium, which incorporates a control law for obstacle avoidance (whether insulating or conductive) in kinematics**. 

The details on the work are available in [TP_sens_electrique_CarlosSantosSeisdedos.pdf](doc\TP_sens_electrique_CarlosSantosSeisdedos.pdf). 

Contents: 
- Chapter 2: Modeling approach
    - introduction to the simulated fish robot, 
    - a solution to the active electrolocation problem known as _"reflection method"_ used in the simulator and 
    - results obtained for small conductive and isolating objets. 
- Chapter 3: Control Law approach
    - control law approach used to simulate the fish movements while avoiding obstacles,
    - results obtained for this control law. 

## Usage

1. Clone this repository
2. Launch Matlab (version tested: R2018b)
3. Change Matlab's path
4. Run Matlab scripts located in `src`: `s_Electric_Sense_commande.m` and `s_Electric_Sense_modelisation.m`.

## References
- [1] Bio-inspiration, Wikipedia, 19/03/2022, URL : fr.wikipedia.org/wiki/Bio-inspiration
- [2] Rigoberto González Gutiérrez, Los peces eléctricos (orden Gymnotiformes) de Panamá, Instituto Smithsonian de Investigaciones Tropicales (STRI), Laboratorio de Naos, Panamá, ©EDUNACHI, 2014
- [3] Poisson-éléphant, Wikipedia, 19/03/22, URL : fr.wikipedia.org/wiki/Poisson-éléphant
- [4] Mohammed-Rédha Benachenhou, Électrolocation dans un contexte multi-robots : théorie et expérimentations, Thèse de Doctorat, École Centrale de Nantes, 2014.
- [5] Frédéric Boyer, Pol Bernard Gossiaux, Brahim Jawad, Vincent Lebastard and Mathieu Porez, Model for a sensor inspired by electric fish, JOURNAL OF IEEE TRANSACTIONS ON ROBOTICS, 2012.
- [6] Frédéric Boyer, Vincent Lebastard, Christine Chevallereau, and Noël Servagen, Underwater Reflex Navigation in Confined Environment Based on Electric Sense, IEEE TRANSACTIONS ON ROBOTICS, VOL. 29, NO. 4, AUGUST 2013
- [7] Mohammed-Rédha Benachenhou, Frédéric Boyer, Christine Chevallereau, Vincent Lebastard, Fast simulator of the electric sense for complex scene.
[8] John David Jackson, Clasiccal Electrodynamics, John Wiley & Sons, 1962.
