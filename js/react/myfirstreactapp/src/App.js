import logo from './logo.svg';
import mshlogo from './msh-logo-white.svg';
import './App.css';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          The First React App by MelindaH26.
        </p>
        <img src={mshlogo} className="msh-logo" alt="msh logo" />
      </header>
    </div>
  );
}

export default App;
