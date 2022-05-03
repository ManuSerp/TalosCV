# Compte rendu

## Programme python

### Problèmes précedent

- asynchronicité
- not enough accuracy for the controlleur
- profondeur

#### Asynchronicité

Un des plus gros problème que le trackeur avait pour fonctionner correctement était que le controlleur de tracking donnait la position à l'instant même ou le réseau profond avait fini le traitement, or ce temps n'est pas une constante et sur mon ordinateur varie entre 0.17 et 0.25s. Ceci provoquait l'envoi de point a tracker a un rythme non controllé.
Au début le robot utilisait le tracking mode, qui se déplace instaténement a un point donné. Ainsi dans ce cas la le temps de traitement aléatoire ne posait pas de souci mais cependant pour ne pas que le bras accelere trop vite le point a rejoindre en tracking mode doit etre à moins de 2cm du preècedent, une précision que n'offre pas le réseau ( +- 4cm ).
Le programme bloquait donc régulièrement et n'offrait aps un tracking suffisant.

Nous avons donc décidé d'utiliser le trajmode entre les points et pour que ce soit fiable j'ai cadencé l'algorithme de tracking à 4hz, un point est donc émis tout les 4hz, en cela j'ai pu régler le traj mode sur une durée de 0.25 secondes ( entre chaques fois).

#### Profondeur

Précedemment j'utilisais un étalonnage de la camèra pour associer position et pixels, cependant cela n'etait pas très précis, se repercutant dans le tracking, j'ai réglé ce profondeeur en utilisant la matrice pixels-profondeur founis par la lib pcl directement, avec un ros node. La précision de tracking a donc bien augmenté.

#### Conclusion

En conclusion le logiciel de tracking est donc fonctionel mais il y a toujours un souci, quand le bras du robot passe devant l'objet à tracker on perd le tracking, on en est donc venu a un nouvel objectif: Comment eviter que le bras du Tiago ne pertube le tracking.

L'idée que nous avons eu est d'utiliser le système anti-collision du controlleur corp complets.
Quand le controlleur chercher à placer le gripper du robot à un endroit donner il vas effectuer un résolution quadratique sur toute ses contraintes pour trouver une solution ( aka trouver une position pour tout ses axes qui satisfasse les contraintes d'équilibres et de collsions). Une contrainte de collisions est représenté par une donction de loss avec un poit (pr le controlleur), par un point du robot et des sphères répartit sur le robot. Quand le point entre dans une sphères la loss augmente proportionellement au poids, ici on utilise des exp(-x) et donc très rapidement la loss est très grande dans les sphères, ainsi le controlleur prohibe naturellemnt les positions avec collisions.

L'idée est donc de placer des sphères virtuelles dans le champs de vision pour que le controlleur cherche naturellement a esquiver le champs de vision du robot lorsque il bouge le bras. cependant peut etre que la fonction de loss actuelle entraine des contraintes trop importante et vas peut etre nous faire des cas ou il n'ya pas de solutions. Il faut donc faire des test car il est possible que meme si le bras entra un peu dans la sphère de champs ce n'est pas très grave. A voir.

#### Sur la tentative de prevenir du champ de vision:

Malheuresement cela s'avère plus compliqué que prévu, après avoir défini un cone de vision pour le robot le bras ne se comporte pas du tout comme prévu. En effet malgré la mise en place de cone d'occlusion le bras à du mal a l'éviter et en particulier a faire des mouvements d'évitement de roration du coude, ceci provient en partie du fait que le robot ne voit pas le futur, c'est a dire que il ne peut savoir que meme si sur le moment partir vers le bas ne lui apporte rien dans les instants suivant ca lui fera gagner du gradient. Et donc il ne le fait pas.
