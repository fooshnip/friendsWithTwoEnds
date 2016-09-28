//import java.net.DatagramSocket;
//import java.net.DatagramPacket;
//import java.net.InetAddress;
//import java.net.SocketException;
//import java.net.UnknownHostException;


//public class GameServer extends Thread {
  
//  private InetAddress ipAddress;
//  private DatagramSocket socket;
  
//  public GameServer(){
//    try {
//    this.socket = new DatagramSocket(1331);
//    } catch (SocketException e) {
//      e.printStackTrace();
//    }
//  }
  
//  public void run() {
//    while (true) {
//      byte[] data = new byte[1024];
//      DatagramPacket packet = new DatagramPacket(data, data.length);
//      try {
//        socket.receive(packet);
//      } catch (IOException e) {
//        e.printStackTrace();
//      }
//      String message = new String(packet.getData());
//      System.out.println("CLIENT > " + message);
//      if (message.trim().("ping")
//    }
//  }
  
//  public void sendData(byte[] data) {
//    DatagramPacket packet = new DatagramPacket(data, data.length, ipAddress, 1331);
//    try {
//      socket.send(packet);
//    } catch (IOException e){
//      e.printStackTrace();
//    }
//  }
  
//}