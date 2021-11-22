
CREATE TABLE public.pizza (
                id INTEGER NOT NULL,
                nom VARCHAR(50) NOT NULL,
                prixHt DOUBLE PRECISION NOT NULL,
                recette TEXT NOT NULL,
                tva100 DOUBLE PRECISION NOT NULL,
                CONSTRAINT pizza_pk PRIMARY KEY (id)
);


CREATE TABLE public.adresse (
                id INTEGER NOT NULL,
                numero INTEGER NOT NULL,
                rue VARCHAR(50) NOT NULL,
                codePostal INTEGER NOT NULL,
                ville VARCHAR(100) NOT NULL,
                CONSTRAINT adresse_pk PRIMARY KEY (id)
);


CREATE TABLE public.pizzeria (
                id INTEGER NOT NULL,
                nom VARCHAR(100) NOT NULL,
                adresse_id INTEGER NOT NULL,
                CONSTRAINT pizzeria_pk PRIMARY KEY (id)
);


CREATE TABLE public.ingredient (
                id INTEGER NOT NULL,
                nom VARCHAR(50) NOT NULL,
                CONSTRAINT ingredient_pk PRIMARY KEY (id)
);


CREATE TABLE public.pizza_ingredient (
                id_ingredient INTEGER NOT NULL,
                id_pizza INTEGER NOT NULL,
                quantite INTEGER NOT NULL,
                CONSTRAINT pizza_ingredient_pk PRIMARY KEY (id_ingredient, id_pizza)
);


CREATE TABLE public.stock (
                id_ingredient INTEGER NOT NULL,
                id_pizzeria INTEGER NOT NULL,
                quantite INTEGER NOT NULL,
                CONSTRAINT stock_pk PRIMARY KEY (id_ingredient, id_pizzeria)
);


CREATE TABLE public.utilisateur (
                id INTEGER NOT NULL,
                nom VARCHAR(100) NOT NULL,
                prenom VARCHAR(100) NOT NULL,
                mot_de_passe VARCHAR(20) NOT NULL,
                mail VARCHAR(100) NOT NULL,
                CONSTRAINT utilisateur_pk PRIMARY KEY (id)
);


CREATE TABLE public.client (
                id INTEGER NOT NULL,
                adresse_id INTEGER NOT NULL,
                telephone INTEGER NOT NULL,
                CONSTRAINT client_pk PRIMARY KEY (id)
);


CREATE TABLE public.panier (
                id INTEGER NOT NULL,
                paiement BOOLEAN NOT NULL,
                prixHt DOUBLE PRECISION NOT NULL,
                tva100 DOUBLE PRECISION NOT NULL,
                id_client INTEGER NOT NULL,
                CONSTRAINT panier_pk PRIMARY KEY (id)
);


CREATE TABLE public.panier_pizza (
                id_panier INTEGER NOT NULL,
                id_pizza INTEGER NOT NULL,
                quantite INTEGER NOT NULL,
                CONSTRAINT panier_pizza_pk PRIMARY KEY (id_panier, id_pizza)
);


CREATE TABLE public.personnel (
                id INTEGER NOT NULL,
                fonction VARCHAR NOT NULL,
                id_pizzeria INTEGER NOT NULL,
                CONSTRAINT personnel_pk PRIMARY KEY (id)
);


CREATE TABLE public.commande (
                id INTEGER NOT NULL,
                paiement BOOLEAN NOT NULL,
                etat VARCHAR(20) NOT NULL,
                date DATE,
                id_panier INTEGER NOT NULL,
                id_personnel INTEGER NOT NULL,
                CONSTRAINT commande_pk PRIMARY KEY (id)
);


CREATE TABLE public.livraison (
                id INTEGER NOT NULL,
                date DATE NOT NULL,
                id_client INTEGER NOT NULL,
                id_commande INTEGER NOT NULL,
                CONSTRAINT livraison_pk PRIMARY KEY (id)
);


CREATE TABLE public.paiement (
                id INTEGER NOT NULL,
                typePaiement VARCHAR(20) NOT NULL,
                id_commande INTEGER NOT NULL,
                date DATE,
                paiement BOOLEAN NOT NULL,
                CONSTRAINT paiement_pk PRIMARY KEY (id)
);


ALTER TABLE public.pizza_ingredient ADD CONSTRAINT pizza_ingredient_pizza_fk
FOREIGN KEY (id_pizza)
REFERENCES public.pizza (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.panier_pizza ADD CONSTRAINT pizza_panier_pizza_fk
FOREIGN KEY (id_pizza)
REFERENCES public.pizza (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.client ADD CONSTRAINT adresse_client_fk
FOREIGN KEY (adresse_id)
REFERENCES public.adresse (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pizzeria ADD CONSTRAINT adresse_adresse_fk
FOREIGN KEY (adresse_id)
REFERENCES public.adresse (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.personnel ADD CONSTRAINT personnel_pizzeria_fk
FOREIGN KEY (id_pizzeria)
REFERENCES public.pizzeria (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.stock ADD CONSTRAINT pizzeria_stock_fk
FOREIGN KEY (id_pizzeria)
REFERENCES public.pizzeria (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.stock ADD CONSTRAINT stock_ingredient_fk
FOREIGN KEY (id_ingredient)
REFERENCES public.ingredient (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pizza_ingredient ADD CONSTRAINT ingredient_pizza_ingredient_fk
FOREIGN KEY (id_ingredient)
REFERENCES public.ingredient (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.personnel ADD CONSTRAINT personnel_utilisateur__fk
FOREIGN KEY (id)
REFERENCES public.utilisateur (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.client ADD CONSTRAINT client_utilisateur__fk
FOREIGN KEY (id)
REFERENCES public.utilisateur (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.panier ADD CONSTRAINT client_panier_fk
FOREIGN KEY (id_client)
REFERENCES public.client (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.livraison ADD CONSTRAINT client_livraison_fk
FOREIGN KEY (id_client)
REFERENCES public.client (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.panier_pizza ADD CONSTRAINT panier_panier_pizza_fk
FOREIGN KEY (id_panier)
REFERENCES public.panier (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.commande ADD CONSTRAINT panier_commande_fk
FOREIGN KEY (id_panier)
REFERENCES public.panier (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.commande ADD CONSTRAINT personnel_commande_fk
FOREIGN KEY (id_personnel)
REFERENCES public.personnel (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.paiement ADD CONSTRAINT commande_paiement__fk
FOREIGN KEY (id_commande)
REFERENCES public.commande (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.livraison ADD CONSTRAINT commande_livraison_fk
FOREIGN KEY (id_commande)
REFERENCES public.commande (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
