# 6T SRAM Cell Design (Schematic + Netlist)

## 📌 Introduction
Static Random Access Memory (SRAM) is a type of volatile memory that uses **bistable latching circuitry** to store data.  
The **6-Transistor (6T) SRAM cell** is the most common design, widely used in caches and high-speed memory arrays.  

A 6T SRAM cell consists of:
- **Two cross-coupled CMOS inverters** → to store a bit (`Q` and `Q̅`).
- **Two access transistors** → to connect the storage nodes to the **bit-lines (BL, BL̅)** when the **wordline (WL)** is activated.  

The same layout and circuit supports both **read** and **write** operations depending on WL and BL/BL̅ signals.

---

## 📐 Circuit Design
- **Technology used:** CMOS (45nm technology node in layout example).  
- **Supply voltage (Vdd):** 5V  
- **Components:**
  - 2 NMOS access transistors
  - 2 NMOS + 2 PMOS for cross-coupled inverters
  - Bit-line capacitances for read simulation  

---

## ⚡ Netlists

### ✅ Write Operation Netlist
- WL is asserted high.
- Data is forced from BL/BL̅ into the storage nodes.
- The cell overwrites the previous stored value.

File: [`netlist/6T_SRAM_write.spice`](Netlist/6TSRAM_WriteOperation.cir)

### ✅ Read Operation Netlist
- Both BL and BL̅ precharged.
- WL enabled → storage node pulls one bitline slightly lower.
- Sense amplifiers in real SRAM arrays detect this small difference.

File: [`netlist/6T_SRAM_read.spice`](netlist/6T_SRAM_read.spice)

---

## 🖼 Layout Design
The layout was created based on **lambda design rules** and scaled to **45nm technology node**.  

- **Inputs/Outputs:**  
  - `WL` → Wordline  
  - `BL`, `BL̅` → Bitlines  
  - `Q`, `Q̅` → Storage nodes  
  - `Vdd`, `Vss` → Power rails  

![Layout Example](docs/Layout_Screenshot.png)

---

## 📊 Simulation Results

### 📝 Write Operation
- BL is driven high/low while WL is enabled.
- The storage node `Q` follows BL and flips accordingly.
- Measured **write delay**: ~270–310 ps.

![Write Waveform](docs/Write_Waveform.png)

### 📝 Read Operation
- Both BL and BL̅ precharged to ~Vdd/2.
- When WL is enabled, one bitline discharges slightly depending on stored value.
- Confirms **correct read functionality**.

![Read Waveform](docs/Read_Waveform.png)

---

## 🛠 Tools Used
- **Schematic & Netlist:** eSim / Ngspice  
- **Layout:** Cadence Virtuoso (lambda rules, 45nm tech node)  
- **Simulation:** Ngspice transient analysis  

---

## 📌 Conclusion
- Designed and simulated a **6T SRAM cell**.  
- Verified correct **read and write operations** using transient analysis.  
- Layout was implemented and matched with the schematic design.  
- Write delay measured in the order of **hundreds of picoseconds**.  

---

